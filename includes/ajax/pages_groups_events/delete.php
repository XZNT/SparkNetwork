<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true);

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

// valid inputs
if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
  _error(400);
}

try {

  switch ($_POST['handle']) {
    case 'page':
      // delete page
      $user->delete_page($_POST['id']);
      break;

    case 'group':
      // delete group
      $user->delete_group($_POST['id']);
      break;

    case 'event':
      // delete event
      $user->delete_event($_POST['id']);
      break;

    default:
      _error(400);
      break;
  }

  // return
  return_json();
} catch (Exception $e) {
  modal("MESSAGE", __("Error"), $e->getMessage());
}
