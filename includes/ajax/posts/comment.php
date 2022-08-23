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
$valid['handle'] = array('post', 'photo', 'comment');
if (!in_array($_POST['handle'], $valid['handle'])) {
  _error(400);
}
/* if id is set & not numeric */
if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
  _error(400);
}
/* if message not set */
if (!isset($_POST['message'])) {
  _error(400);
}
/* filter comment photo */
if (isset($_POST['photo'])) {
  $_POST['photo'] = json_decode($_POST['photo']);
}
/* filter comment voice_note */
if (isset($_POST['voice_note'])) {
  $_POST['voice_note'] = json_decode($_POST['voice_note']);
}

try {

  // initialize the return array
  $return = array();

  // comment
  $comment = $user->comment($_POST['handle'], $_POST['id'], $_POST['message'], $_POST['photo'], $_POST['voice_note']);
  /* assign variables */
  $smarty->assign('_is_reply', ($_POST['handle'] == "comment") ? true : false);
  $smarty->assign('_comment', $comment);
  /* return */
  $return['comment'] = $smarty->fetch("__feeds_comment.tpl");

  // return & exit
  return_json($return);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
