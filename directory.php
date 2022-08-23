<?php
// fetch bootloader
require('bootloader.php');

// user access
if (!$system['directory_enabled']) {
  _error(404);
}

// user access
if ($user->_logged_in || !$system['system_public']) {
  user_access();
}

try {

  // get view content
  switch ($_GET['view']) {
    case '':
      // page header
      page_header(__($system['system_title']) . ' - ' . __("Directory"), __($system['system_description_directory']));
      break;

    case 'users':
      // page header
      page_header(__($system['system_title']) . ' - ' . __("Users Directory"), __($system['system_description_directory']));

      // pager config
      require('includes/class-pager.php');
      $params['selected_page'] = ((int) $_GET['page'] == 0) ? 1 : $_GET['page'];
      $total = $db->query("SELECT COUNT(*) as count FROM users") or _error("SQL_ERROR");
      $params['total_items'] = $total->fetch_assoc()['count'];
      $params['items_per_page'] = $system['max_results'];
      $params['url'] = $system['system_url'] . '/directory/' . 'users' . '/%s';
      $pager = new Pager($params);
      $limit_query = $pager->getLimitSql();

      // get users
      $rows = [];
      $get_rows = $db->query("SELECT * FROM users " . $limit_query) or _error("SQL_ERROR");
      while ($row = $get_rows->fetch_assoc()) {
        $row['user_picture'] = get_picture($row['user_picture'], $row['user_gender']);
        /* get the connection between the viewer & the target */
        $row['connection'] = $user->connection($row['user_id']);
        $rows[] = $row;
      }
      /* assign variables */
      $smarty->assign('rows', $rows);
      $smarty->assign('pager', $pager->getPager());
      break;

    case 'posts':
      // page header
      page_header(__($system['system_title']) . ' - ' . __("Posts Directory"), __($system['system_description_directory']));

      // pager config
      require('includes/class-pager.php');
      $params['selected_page'] = ((int) $_GET['page'] == 0) ? 1 : $_GET['page'];
      $total = $db->query("SELECT COUNT(*) as count FROM posts LEFT JOIN users ON posts.user_id = users.user_id AND posts.user_type = 'user' LEFT JOIN pages ON posts.user_id = pages.page_id AND posts.user_type = 'page' LEFT JOIN `groups` ON posts.in_group = '1' AND posts.group_id = `groups`.group_id LEFT JOIN `events` ON posts.in_event = '1' AND posts.event_id = `events`.event_id WHERE posts.privacy = 'public' AND NOT (users.user_name <=> NULL AND pages.page_name <=> NULL)") or _error("SQL_ERROR");
      $params['total_items'] = $total->fetch_assoc()['count'];
      $params['items_per_page'] = $system['max_results'];
      $params['url'] = $system['system_url'] . '/directory/' . 'posts' . '/%s';
      $pager = new Pager($params);
      $limit_query = $pager->getLimitSql();

      // get posts
      $rows = [];
      $get_rows = $db->query("SELECT posts.post_id FROM posts LEFT JOIN users ON posts.user_id = users.user_id AND posts.user_type = 'user' LEFT JOIN pages ON posts.user_id = pages.page_id AND posts.user_type = 'page' LEFT JOIN `groups` ON posts.in_group = '1' AND posts.group_id = `groups`.group_id LEFT JOIN `events` ON posts.in_event = '1' AND posts.event_id = `events`.event_id WHERE posts.privacy = 'public' AND NOT (users.user_name <=> NULL AND pages.page_name <=> NULL) " . $limit_query) or _error("SQL_ERROR");
      while ($row = $get_rows->fetch_assoc()) {
        $row = $user->get_post($row['post_id']);
        if ($row) {
          $rows[] = $row;
        }
      }
      /* assign variables */
      $smarty->assign('rows', $rows);
      $smarty->assign('pager', $pager->getPager());
      break;

    case 'pages':
      // pages enabled
      if (!$system['pages_enabled']) {
        _error(404);
      }

      // page header
      page_header(__($system['system_title']) . ' - ' . __("Pages Directory"), __($system['system_description_directory']));

      // pager config
      require('includes/class-pager.php');
      $params['selected_page'] = ((int) $_GET['page'] == 0) ? 1 : $_GET['page'];
      $total = $db->query("SELECT COUNT(*) as count FROM pages") or _error("SQL_ERROR");
      $params['total_items'] = $total->fetch_assoc()['count'];
      $params['items_per_page'] = $system['max_results'];
      $params['url'] = $system['system_url'] . '/directory/' . 'pages' . '/%s';
      $pager = new Pager($params);
      $limit_query = $pager->getLimitSql();

      // get pages
      $rows = [];
      $get_rows = $db->query("SELECT * FROM pages " . $limit_query) or _error("SQL_ERROR");
      while ($row = $get_rows->fetch_assoc()) {
        $row['page_picture'] = get_picture($row['page_picture'], 'page');
        /* check if the viewer liked the page */
        $row['i_like'] = false;
        if ($user->_logged_in) {
          $get_likes = $db->query(sprintf("SELECT * FROM pages_likes WHERE page_id = %s AND user_id = %s", secure($row['page_id'], 'int'), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR");
          if ($get_likes->num_rows > 0) {
            $row['i_like'] = true;
          }
        }
        $rows[] = $row;
      }
      /* assign variables */
      $smarty->assign('rows', $rows);
      $smarty->assign('pager', $pager->getPager());
      break;

    case 'groups':
      // groups enabled
      if (!$system['groups_enabled']) {
        _error(404);
      }

      // page header
      page_header(__($system['system_title']) . ' - ' . __("Pages Directory"), __($system['system_description_directory']));

      // pager config
      require('includes/class-pager.php');
      $params['selected_page'] = ((int) $_GET['page'] == 0) ? 1 : $_GET['page'];
      $total = $db->query("SELECT COUNT(*) as count FROM `groups` WHERE group_privacy = 'public'") or _error("SQL_ERROR");
      $params['total_items'] = $total->fetch_assoc()['count'];
      $params['items_per_page'] = $system['max_results'];
      $params['url'] = $system['system_url'] . '/directory/' . 'groups' . '/%s';
      $pager = new Pager($params);
      $limit_query = $pager->getLimitSql();

      // get groups
      $rows = [];
      $get_rows = $db->query("SELECT * FROM `groups` WHERE group_privacy = 'public' " . $limit_query) or _error("SQL_ERROR");
      while ($row = $get_rows->fetch_assoc()) {
        $row['group_picture'] = get_picture($row['group_picture'], 'group');
        /* check if the viewer joined the group */
        $row['i_joined'] = $user->check_group_membership($user->_data['user_id'], $row['group_id']);
        $rows[] = $row;
      }
      /* assign variables */
      $smarty->assign('rows', $rows);
      $smarty->assign('pager', $pager->getPager());
      break;

    case 'events':
      // events enabled
      if (!$system['events_enabled']) {
        _error(404);
      }

      // page header
      page_header(__($system['system_title']) . ' - ' . __("Events Directory"), __($system['system_description_directory']));

      // pager config
      require('includes/class-pager.php');
      $params['selected_page'] = ((int) $_GET['page'] == 0) ? 1 : $_GET['page'];
      $total = $db->query("SELECT COUNT(*) as count FROM `events` WHERE event_privacy = 'public'") or _error("SQL_ERROR");
      $params['total_items'] = $total->fetch_assoc()['count'];
      $params['items_per_page'] = $system['max_results'];
      $params['url'] = $system['system_url'] . '/directory/' . 'events' . '/%s';
      $pager = new Pager($params);
      $limit_query = $pager->getLimitSql();

      // get events
      $rows = [];
      $get_rows = $db->query("SELECT * FROM `events` WHERE event_privacy = 'public' " . $limit_query) or _error("SQL_ERROR");
      while ($row = $get_rows->fetch_assoc()) {
        $row['event_picture'] = get_picture($row['event_cover'], 'event');
        /* check if the viewer joined the event */
        $row['i_joined'] = $user->check_event_membership($user->_data['user_id'], $row['event_id']);
        $rows[] = $row;
      }
      /* assign variables */
      $smarty->assign('rows', $rows);
      $smarty->assign('pager', $pager->getPager());
      break;

    case 'games':
      // games enabled
      if (!$system['games_enabled']) {
        _error(404);
      }

      // page header
      page_header(__($system['system_title']) . ' - ' . __("Games Directory"), __($system['system_description_directory']));

      // pager config
      require('includes/class-pager.php');
      $params['selected_page'] = ((int) $_GET['page'] == 0) ? 1 : $_GET['page'];
      $total = $db->query("SELECT COUNT(*) as count FROM games") or _error("SQL_ERROR");
      $params['total_items'] = $total->fetch_assoc()['count'];
      $params['items_per_page'] = $system['max_results'];
      $params['url'] = $system['system_url'] . '/directory/' . 'games' . '/%s';
      $pager = new Pager($params);
      $limit_query = $pager->getLimitSql();

      // get games
      $rows = [];
      $get_rows = $db->query("SELECT * FROM games " . $limit_query) or _error("SQL_ERROR");
      while ($row = $get_rows->fetch_assoc()) {
        $row['thumbnail'] = get_picture($row['thumbnail'], 'game');
        $row['title_url'] = get_url_text($row['title']);
        $rows[] = $row;
      }
      /* assign variables */
      $smarty->assign('rows', $rows);
      $smarty->assign('pager', $pager->getPager());
      break;

    default:
      _error(404);
      break;
  }
  /* assign variables */
  $smarty->assign('view', $_GET['view']);

  // get ads campaigns
  $ads_campaigns = $user->ads_campaigns();
  /* assign variables */
  $smarty->assign('ads_campaigns', $ads_campaigns);

  // get ads
  $ads = $user->ads('directory');
  /* assign variables */
  $smarty->assign('ads', $ads);

  // get widgets
  $widgets = $user->widgets('directory');
  /* assign variables */
  $smarty->assign('widgets', $widgets);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer("directory");
