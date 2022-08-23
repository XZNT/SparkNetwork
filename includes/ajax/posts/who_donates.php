<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true);

// valid inputs
if (!isset($_GET['post_id']) || !is_numeric($_GET['post_id'])) {
  _error(400);
}

try {

  // initialize the return array
  $return = array();

  // get donors
  $users = $user->who_donates($_GET['post_id']);
  /* assign variables */
  $smarty->assign('users', $users);
  $smarty->assign('id', $_GET['post_id']);
  /* return */
  $return['template'] = $smarty->fetch("ajax.who_donates.tpl");
  $return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template);";

  // return & exit
  return_json($return);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
