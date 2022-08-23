<?php

// fetch bootloader
require('bootloader.php');

// jobs enabled
if (!$system['pages_enabled'] || !$system['jobs_enabled']) {
  _error(404);
}

// user access
if ($user->_logged_in || !$system['system_public']) {
  user_access();
}

try {

  // get view content
  $_GET['view'] = (isset($_GET['view'])) ? $_GET['view'] : '';
  switch ($_GET['view']) {
    case '':
      // get promoted jobs
      $promoted_jobs = array();
      $get_promoted = $db->query("SELECT posts.post_id FROM posts INNER JOIN posts_jobs ON posts.post_id = posts_jobs.post_id WHERE posts.post_type = 'job' AND posts_jobs.available = '1' AND posts.boosted = '1' ORDER BY RAND() LIMIT 3") or _error("SQL_ERROR");
      while ($promoted_job = $get_promoted->fetch_assoc()) {
        $promoted_job = $user->get_post($promoted_job['post_id']);
        if ($promoted_job) {
          $promoted_jobs[] = $promoted_job;
        }
      }
      /* assign variables */
      $smarty->assign('promoted_jobs', $promoted_jobs);

      // prepare query
      /* prepare where query */
      $where_query = "";
      /* prepare pager url */
      $url = "";

      // page header
      page_header(__($system['system_title']) . ' - ' . __("Jobs"), __($system['system_description_jobs']));

      // get jobs categories
      $categories = $user->get_categories("jobs_categories");
      /* assign variables */
      $smarty->assign('categories', $categories);
      break;

    case 'search':
      // check query
      if (!isset($_GET['query']) || is_empty($_GET['query'])) {
        redirect('/jobs');
      }
      /* assign variables */
      $smarty->assign('query', $_GET['query']);

      // prepare query
      /* prepare where query */
      $where_query = sprintf('AND (posts.text LIKE %1$s OR posts_jobs.title LIKE %1$s)', secure($_GET['query'], 'search'));
      /* prepare pager url */
      $url = "/search/" . $_GET['query'];

      // page header
      page_header(__($system['system_title']) . ' - ' . __("Jobs"), __($system['system_description_jobs']));

      // get jobs categories
      $categories = $user->get_categories("jobs_categories");
      /* assign variables */
      $smarty->assign('categories', $categories);
      break;

    case 'category':
      // check category
      $current_category = $user->get_category("jobs_categories", $_GET['category_id'], true);
      if (!$current_category) {
        _error(404);
      }
      /* assign variables */
      $smarty->assign('current_category', $current_category);

      // prepare query
      /* prepare where query */
      $where_query = sprintf("AND posts_jobs.category_id = %s", secure($current_category['category_id'], 'int'));
      /* prepare pager url */
      $url = "/category/" . $current_category['category_id'] . "/" . $current_category['category_url'];

      // page header
      page_header(__($system['system_title']) . ' - ' . __("Jobs") . ' - ' . __($current_category['category_name']), __($current_category['category_description']));

      // get market categories (only sub-categories)
      if (!$current_category['sub_categories'] && !$current_category['parent']) {
        $categories = $user->get_categories("jobs_categories");
      } else {
        $categories = $user->get_categories("jobs_categories", $current_category['category_id']);
      }
      /* assign variables */
      $smarty->assign('categories', $categories);
      break;

    default:
      _error(404);
      break;
  }

  // prepare queries
  $distance_clause = "";
  $distance_join = "";
  $distance_query = "";
  $order_query = "";

  // prepare distance
  if ($user->_logged_in && $system['location_finder_enabled'] && isset($_GET['distance']) && is_numeric($_GET['distance'])) {
    /* validate distance */
    $distance = $_GET['distance'];
    $unit = ($system['system_distance'] == "mile") ? 3958 : 6371;
    $distance = ($_GET['distance'] && is_numeric($_GET['distance']) && $_GET['distance'] > 0) ? $_GET['distance'] : 25;
    $distance_clause = sprintf(", (%s * acos(cos(radians(%s)) * cos(radians(user_latitude)) * cos(radians(user_longitude) - radians(%s)) + sin(radians(%s)) * sin(radians(user_latitude))) ) AS distance ", secure($unit, 'int'), secure($user->_data['user_latitude']), secure($user->_data['user_longitude']), secure($user->_data['user_latitude']));
    $distance_query .= sprintf(" HAVING distance < %s ", secure($distance, 'int'));
    $distance_join = " INNER JOIN users ON users.user_id = (SELECT page_admin FROM pages WHERE pages.page_id = posts.user_id) ";
    $order_query .= " ORDER BY distance ASC ";
  }

  // prepare sort
  $order_query .= ($order_query) ? "," : " ORDER BY ";
  switch ($_GET['sort']) {
    case '':
    case 'latest':
      $order_query .= " posts.post_id DESC ";
      break;

    case 'salary-high':
      $order_query .= " posts_jobs.salary_maximum DESC ";
      break;

    case 'salary-low':
      $order_query .= " posts_jobs.salary_maximum ASC ";
      break;

    default:
      _error(404);
      break;
  }

  // get jobs
  require('includes/class-pager.php');
  $params['selected_page'] = ((int) $_GET['page'] == 0) ? 1 : $_GET['page'];
  $total = $db->query("SELECT COUNT(*) as count " . $distance_clause . " FROM posts INNER JOIN posts_jobs ON posts.post_id = posts_jobs.post_id " . $distance_join . " WHERE posts_jobs.available = '1'" . $where_query . $distance_query . $order_query) or _error("SQL_ERROR");
  $params['total_items'] = $total->fetch_assoc()['count'];
  $params['items_per_page'] = $system['jobs_results'];
  $params['url'] = $system['system_url'] . '/jobs' . $url . '/%s';
  $params['url'] .= (isset($distance)) ? "?distance=" . $distance : "";
  if (isset($_GET['sort'])) {
    $params['url'] .= ($distance) ? "&" : "?";
    $params['url'] .= "sort=" . $_GET['sort'];
  }
  $pager = new Pager($params);
  $limit_query = $pager->getLimitSql();

  // get posts
  $rows = array();
  $get_rows = $db->query("SELECT posts.post_id " . $distance_clause . " FROM posts INNER JOIN posts_jobs ON posts.post_id = posts_jobs.post_id " . $distance_join . " WHERE posts_jobs.available = '1'" . $where_query . $distance_query . $order_query . $limit_query) or _error("SQL_ERROR");
  while ($row = $get_rows->fetch_assoc()) {
    $row = $user->get_post($row['post_id']);
    if ($row) {
      $rows[] = $row;
    }
  }
  /* assign variables */
  $smarty->assign('sort', $_GET['sort']);
  $smarty->assign('distance', htmlentities($distance, ENT_QUOTES, 'utf-8'));
  $smarty->assign('rows', $rows);
  $smarty->assign('total', $params['total_items']);
  $smarty->assign('pager', $pager->getPager());
  $smarty->assign('view', $_GET['view']);

  // get ads
  $ads = $user->ads('jobs');
  /* assign variables */
  $smarty->assign('ads', $ads);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer("jobs");
