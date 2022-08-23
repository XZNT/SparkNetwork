<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// check admin|moderator permission
if (!$user->_is_admin && !$user->_is_moderator) {
  modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
}

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

// handle forums
try {

  switch ($_GET['do']) {
    case 'add_forum':
      /* insert */
      $db->query(sprintf("INSERT INTO forums (forum_name, forum_description, forum_section, forum_order) VALUES (%s, %s, %s, %s)", secure($_POST['forum_name']), secure($_POST['forum_description']), secure($_POST['forum_section'], 'int'), secure($_POST['forum_order'], 'int'))) or _error("SQL_ERROR_THROWEN");
      /* return */
      return_json(array('callback' => 'window.location = "' . $system['system_url'] . '/' . $control_panel['url'] . '/forums";'));
      break;

    case 'edit_forum':
      /* valid inputs */
      if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
        _error(400);
      }
      if ($_GET['id'] == $_POST['forum_section']) {
        throw new Exception(__("You can not set the forum as a section to itself"));
      }
      /* update */
      $db->query(sprintf("UPDATE forums SET forum_name = %s, forum_description = %s, forum_section = %s, forum_order = %s WHERE forum_id = %s", secure($_POST['forum_name']), secure($_POST['forum_description']), secure($_POST['forum_section'], 'int'), secure($_POST['forum_order'], 'int'), secure($_GET['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      /* return */
      return_json(array('success' => true, 'message' => __("Forum info have been updated")));
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
