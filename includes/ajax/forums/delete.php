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

  // initialize the return array
  $return = array();

  switch ($_POST['handle']) {
    case 'thread':
      // delete thread
      $forum = $user->delete_forum_thread($_POST['id']);

      // return
      $return['callback'] = 'window.location = "' . $system['system_url'] . '/forums/' . $forum['forum_id'] . '/' . $forum['title_url'] . '"';
      break;

    case 'reply':
      // delete reply
      $user->delete_forum_reply($_POST['id']);

      // return
      $return['callback'] = 'window.location.reload();';
      break;

    default:
      _error(400);
      break;
  }

  // return & exit
  return_json($return);
} catch (Exception $e) {
  modal("MESSAGE", __("Error"), $e->getMessage());
}
