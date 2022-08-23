<?php
// set execution time
set_time_limit(0); /* unlimited max execution time */

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// check admin|moderator permission
if (!$user->_is_admin) {
  modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
}

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

// handle tools
try {

  switch ($_GET['do']) {
    case 'faker':
      switch ($_GET['handle']) {
        case 'users':
          /* valid inputs */
          if (!is_numeric($_POST['users_num']) || $_POST['users_num'] <= 0) {
            throw new Exception(__("You must enter valid number for how many users you want to generate"));
          }
          if ($_POST['users_num'] > 1000) {
            throw new Exception(__("The maximum number of generated users is 1000 per request"));
          }
          // [BACKGROUND PROCESS]
          /* return async */
          return_json_async(['success' => true, 'message' => __("Your request has been sent successfully and will be processed in the background")]);
          /* fake users generator */
          $generated = $user->fake_users_generator($_POST['users_num'], $_POST['default_password'], $_POST['random_Avatar'], $_POST['language']);
          /* post async notification */
          $user->post_notification_async($generated . " " . __("fake users generated successfully"));
          /* return */
          return_json(array('success' => true, 'message' => $generated . " " . __("fake users generated successfully")));
          break;

        case 'pages':
          /* valid inputs */
          if (!is_numeric($_POST['pages_num']) || $_POST['pages_num'] <= 0) {
            throw new Exception(__("You must enter valid number for how many pages you want to generate"));
          }
          if ($_POST['pages_num'] > 1000) {
            throw new Exception(__("The maximum number of generated pages is 1000 per request"));
          }
          /* validate category */
          if (is_empty($_POST['category'])) {
            throw new Exception(__("You must select valid category for your page"));
          }
          $check = $db->query(sprintf("SELECT COUNT(*) as count FROM pages_categories WHERE category_id = %s", secure($_POST['category'], 'int'))) or _error("SQL_ERROR_THROWEN");
          if ($check->fetch_assoc()['count'] == 0) {
            throw new Exception(__("You must select valid category for your page"));
          }
          // [BACKGROUND PROCESS]
          /* return async */
          return_json_async(['success' => true, 'message' => __("Your request has been sent successfully and will be processed in the background")]);
          /* fake pages generator */
          $generated = $user->fake_pages_generator($_POST['pages_num'], $_POST['random_Avatar'], $_POST['language'], $_POST['category']);
          /* post async notification */
          $user->post_notification_async($generated . " " . __("fake pages generated successfully"));
          /* return */
          return_json(array('success' => true, 'message' => $generated . " " . __("fake pages generated successfully")));
          break;

        case 'groups':
          /* valid inputs */
          if (!is_numeric($_POST['groups_num']) || $_POST['groups_num'] <= 0) {
            throw new Exception(__("You must enter valid number for how many groups you want to generate"));
          }
          if ($_POST['groups_num'] > 1000) {
            throw new Exception(__("The maximum number of generated groups is 1000 per request"));
          }
          /* validate category */
          if (is_empty($_POST['category'])) {
            throw new Exception(__("You must select valid category for your group"));
          }
          $check = $db->query(sprintf("SELECT COUNT(*) as count FROM groups_categories WHERE category_id = %s", secure($_POST['category'], 'int'))) or _error("SQL_ERROR_THROWEN");
          if ($check->fetch_assoc()['count'] == 0) {
            throw new Exception(__("You must select valid category for your group"));
          }
          // [BACKGROUND PROCESS]
          /* return async */
          return_json_async(['success' => true, 'message' => __("Your request has been sent successfully and will be processed in the background")]);
          /* fake groups generator */
          $generated = $user->fake_groups_generator($_POST['groups_num'], $_POST['random_Avatar'], $_POST['language'], $_POST['category']);
          /* post async notification */
          $user->post_notification_async($generated . " " . __("fake groups generated successfully"));
          /* return */
          return_json(array('success' => true, 'message' => $generated . " " . __("fake groups generated successfully")));
          break;
      }
      break;

    case 'auto-connect':
      /* prepare */
      $_POST['auto_friend'] = (isset($_POST['auto_friend'])) ? '1' : '0';
      $_POST['auto_follow'] = (isset($_POST['auto_follow'])) ? '1' : '0';
      $_POST['auto_like'] = (isset($_POST['auto_like'])) ? '1' : '0';
      $_POST['auto_join'] = (isset($_POST['auto_join'])) ? '1' : '0';
      /* update */
      update_system_options([
        'auto_friend' => secure($_POST['auto_friend']),
        'auto_friend_users' => secure($_POST['auto_friend_users']),
        'auto_follow' => secure($_POST['auto_follow']),
        'auto_follow_users' => secure($_POST['auto_follow_users']),
        'auto_like' => secure($_POST['auto_like']),
        'auto_like_pages' => secure($_POST['auto_like_pages']),
        'auto_join' => secure($_POST['auto_join']),
        'auto_join_groups' => secure($_POST['auto_join_groups'])
      ]);
      /* return */
      return_json(array('success' => true, 'message' => __("Auto-connect settings have been updated")));
      break;

    case 'garbage-collector':
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async(['success' => true, 'message' => __("Your request has been sent successfully and will be processed in the background")]);
      /* delete rows */
      switch ($_POST['delete']) {
        case 'users_not_activated':
          $db->query("DELETE FROM users WHERE user_activated = '0'") or _error("SQL_ERROR_THROWEN");
          $deleted_rows_count = $db->affected_rows;
          break;

        case 'users_not_logged_week':
          $db->query("DELETE FROM users WHERE user_last_seen < NOW() - INTERVAL 1 WEEK") or _error("SQL_ERROR_THROWEN");
          $deleted_rows_count = $db->affected_rows;
          break;

        case 'users_not_logged_month':
          $db->query("DELETE FROM users WHERE user_last_seen < NOW() - INTERVAL 1 MONTH") or _error("SQL_ERROR_THROWEN");
          $deleted_rows_count = $db->affected_rows;
          break;

        case 'users_not_logged_3_months':
          $db->query("DELETE FROM users WHERE user_last_seen < NOW() - INTERVAL 3 MONTH") or _error("SQL_ERROR_THROWEN");
          $deleted_rows_count = $db->affected_rows;
          break;

        case 'users_not_logged_6_months':
          $db->query("DELETE FROM users WHERE user_last_seen < NOW() - INTERVAL 6 MONTH") or _error("SQL_ERROR_THROWEN");
          $deleted_rows_count = $db->affected_rows;
          break;

        case 'users_not_logged_9_months':
          $db->query("DELETE FROM users WHERE user_last_seen < NOW() - INTERVAL 9 MONTH") or _error("SQL_ERROR_THROWEN");
          $deleted_rows_count = $db->affected_rows;
          break;

        case 'users_not_logged_year':
          $db->query("DELETE FROM users WHERE user_last_seen < NOW() - INTERVAL 1 YEAR") or _error("SQL_ERROR_THROWEN");
          $deleted_rows_count = $db->affected_rows;
          break;

        case 'posts_longer_week':
          $get_posts = $db->query("SELECT post_id FROM posts WHERE time < NOW() - INTERVAL 1 WEEK") or _error("SQL_ERROR_THROWEN");
          if ($get_posts->num_rows > 0) {
            while ($post = $get_posts->fetch_assoc()) {
              $user->delete_post($post['post_id'], false);
            }
          }
          $deleted_rows_count = $get_posts->num_rows;
          break;

        case 'posts_longer_month':
          $get_posts = $db->query("SELECT post_id FROM posts WHERE time < NOW() - INTERVAL 1 MONTH") or _error("SQL_ERROR_THROWEN");
          if ($get_posts->num_rows > 0) {
            while ($post = $get_posts->fetch_assoc()) {
              $user->delete_post($post['post_id'], false);
            }
          }
          $deleted_rows_count = $get_posts->num_rows;
          break;

        case 'posts_longer_year':
          $get_posts = $db->query("SELECT post_id FROM posts WHERE time < NOW() - INTERVAL 1 YEAR") or _error("SQL_ERROR");
          if ($get_posts->num_rows > 0) {
            while ($post = $get_posts->fetch_assoc()) {
              $user->delete_post($post['post_id'], false);
            }
          }
          $deleted_rows_count = $get_posts->num_rows;
          break;

        case 'packages':
          /* garbage collector */
          $user->check_users_package();
          break;

        case 'user_points':
          /* reset users points */
          $user->reset_all_users_points();
          break;

        default:
          _error(400);
          break;
      }
      /* post async notification & return */
      if ($_POST['delete'] == "packages") {
        $user->post_notification_async(__("All expired subscribers and their boosted posts and pages resetted"));
        return_json(array('success' => true, 'message' => __("All expired subscribers and their boosted posts and pages resetted")));
      } elseif ($_POST['delete'] == "user_points") {
        $user->post_notification_async(__("All users points blance have been resetted"));
        return_json(array('success' => true, 'message' => __("All users points balance have been resetted")));
      } else {
        $user->post_notification_async(__("Garbage collector removed") . " " . $deleted_rows_count . " " . __("rows from the database"));
        return_json(array('success' => true, 'message' => __("Garbage collector removed") . "<span class='badge badge-pill badge-lg badge-light mlr5'>" . $deleted_rows_count . "</span>" . __("rows from the database")));
      }
      break;

    case 'backups':
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async(['success' => true, 'message' => __("Your request has been sent successfully and will be processed in the background")]);
      /* backup */
      switch ($_POST['backup_option']) {
        case 'datebase_backup':
          $user->backup_database();
          break;

        case 'files_backup':
          $user->backup_files();
          break;

        case 'full_backup':
          $user->backup_full();
          break;

        default:
          throw new Exception(__("Select which backup you would like to generate"));
          break;
      }
      /* post async notification */
      $user->post_notification_async(__("New backup has been generated"));
      /* return */
      return_json(array('success' => true, 'message' => __("New backup has been generated")));
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
