<?php

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

// handle genders
try {

  switch ($_GET['do']) {
    case 'edit':
      /* valid inputs */
      if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
        _error(400);
      }
      /* update */
      $db->query(sprintf("UPDATE system_genders SET gender_name = %s, gender_order = %s WHERE gender_id = %s", secure($_POST['gender_name']), secure($_POST['gender_order']), secure($_GET['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      /* return */
      return_json(array('success' => true, 'message' => __("Gender info have been updated")));
      break;

    case 'add':
      /* insert */
      $db->query(sprintf("INSERT INTO system_genders (gender_name, gender_order) VALUES (%s, %s)", secure($_POST['gender_name']), secure($_POST['gender_order']))) or _error("SQL_ERROR_THROWEN");
      /* return */
      return_json(array('callback' => 'window.location = "' . $system['system_url'] . '/' . $control_panel['url'] . '/genders";'));
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
