<?php
// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true);

try {


  switch ($_POST['handle']) {
    case 'update':
      // update user location
      $db->query(sprintf("UPDATE users SET onesignal_user_id = %s WHERE user_id = %s", secure($_POST['id']), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'delete':
      // update user location
      $db->query(sprintf("UPDATE users SET onesignal_user_id = '' WHERE user_id = %s", secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    default:
      _error(403);
      break;
  }

  // return
  return_json();
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
