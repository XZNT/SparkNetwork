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

// handle newsletter
try {

  /* valid inputs */
  if (is_empty($_POST['subject'])) {
    throw new Exception(__("You must enter the email subject"));
  }
  if (is_empty($_POST['message'])) {
    throw new Exception(__("You must enter the message subject"));
  }

  /* send email */
  if ($_POST['is_test']) {
    if (!_email($system['system_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']))) {
      throw new Exception(__("Email could not be sent"));
    }
  } else {
    // [BACKGROUND PROCESS]
    /* return async */
    return_json_async(['success' => true, 'message' => __("Your request has been sent successfully and will be processed in the background")]);
    /* send newsletter */
    switch ($_POST['to']) {
      case 'all_users':
        $get_users = $db->query("SELECT user_email FROM users WHERE user_privacy_newsletter = '1'") or _error("SQL_ERROR_THROWEN");
        while ($_user = $get_users->fetch_assoc()) {
          _email($_user['user_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']));
        }
        break;

      case 'users_activated':
        $get_users = $db->query("SELECT user_email FROM users WHERE user_activated = '1' AND user_privacy_newsletter = '1'") or _error("SQL_ERROR_THROWEN");
        while ($_user = $get_users->fetch_assoc()) {
          _email($_user['user_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']));
        }
        break;

      case 'users_not_activated':
        $get_users = $db->query("SELECT user_email FROM users WHERE user_activated = '0' AND user_privacy_newsletter = '1'") or _error("SQL_ERROR_THROWEN");
        while ($_user = $get_users->fetch_assoc()) {
          _email($_user['user_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']));
        }
        break;

      case 'users_not_logged_week':
        $get_users = $db->query("SELECT user_email FROM users WHERE user_last_seen < NOW() - INTERVAL 1 WEEK  AND user_privacy_newsletter = '1'") or _error("SQL_ERROR_THROWEN");
        while ($_user = $get_users->fetch_assoc()) {
          _email($_user['user_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']));
        }
        break;

      case 'users_not_logged_month':
        $get_users = $db->query("SELECT user_email FROM users WHERE user_last_seen < NOW() - INTERVAL 1 MONTH AND user_privacy_newsletter = '1'") or _error("SQL_ERROR_THROWEN");
        while ($_user = $get_users->fetch_assoc()) {
          _email($_user['user_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']));
        }
        break;

      case 'users_not_logged_3_months':
        $get_users = $db->query("SELECT user_email FROM users WHERE user_last_seen < NOW() - INTERVAL 3 MONTH AND user_privacy_newsletter = '1'") or _error("SQL_ERROR_THROWEN");
        while ($_user = $get_users->fetch_assoc()) {
          _email($_user['user_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']));
        }
        break;

      case 'users_not_logged_6_months':
        $get_users = $db->query("SELECT user_email FROM users WHERE user_last_seen < NOW() - INTERVAL 6 MONTH AND user_privacy_newsletter = '1'") or _error("SQL_ERROR_THROWEN");
        while ($_user = $get_users->fetch_assoc()) {
          _email($_user['user_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']));
        }
        break;

      case 'users_not_logged_9_months':
        $get_users = $db->query("SELECT user_email FROM users WHERE user_last_seen < NOW() - INTERVAL 9 MONTH AND user_privacy_newsletter = '1'") or _error("SQL_ERROR_THROWEN");
        while ($_user = $get_users->fetch_assoc()) {
          _email($_user['user_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']));
        }
        break;

      case 'users_not_logged_year':
        $get_users = $db->query("SELECT user_email FROM users WHERE user_last_seen < NOW() - INTERVAL 1 YEAR AND user_privacy_newsletter = '1'") or _error("SQL_ERROR_THROWEN");
        while ($_user = $get_users->fetch_assoc()) {
          _email($_user['user_email'], $_POST['subject'], $_POST['message'], strip_tags($_POST['message']));
        }
        break;
    }
    /* post async notification */
    $user->post_notification_async(__("Newsletter email has been sent successfully"));
  }

  /* return */
  return_json(array('success' => true, 'message' => __("Newsletter email has been sent successfully")));
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
