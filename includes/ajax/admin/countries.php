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

// handle countries
try {

  switch ($_GET['do']) {
    case 'edit':
      /* valid inputs */
      if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
        _error(400);
      }
      /* prepare */
      $_POST['default'] = (isset($_POST['default'])) ? '1' : '0';
      $_POST['enabled'] = (isset($_POST['enabled'])) ? '1' : '0';
      /* if default is set -> set all countries as not default first */
      if ($_POST['default']) {
        $db->query("UPDATE system_countries SET system_countries.default = '0'") or _error("SQL_ERROR_THROWEN");
      }
      /* update */
      $db->query(sprintf("UPDATE system_countries SET system_countries.default = %s, enabled = %s, country_code = %s, country_name = %s, phone_code = %s, country_order = %s WHERE country_id = %s", secure($_POST['default']), secure($_POST['enabled']), secure($_POST['country_code']), secure($_POST['country_name']), secure($_POST['phone_code']), secure($_POST['country_order'], 'int'), secure($_GET['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      /* return */
      return_json(array('success' => true, 'message' => __("Country info have been updated")));
      break;

    case 'add':
      /* prepare */
      $_POST['default'] = (isset($_POST['default'])) ? '1' : '0';
      $_POST['enabled'] = (isset($_POST['enabled'])) ? '1' : '0';
      /* if default is set -> set all countries as not default first */
      if ($_POST['default']) {
        $db->query("UPDATE system_countries SET system_countries.default = '0'") or _error("SQL_ERROR_THROWEN");
      }
      /* insert */
      $db->query(sprintf("INSERT INTO system_countries (system_countries.default, enabled, country_code, country_name, phone_code, country_order) VALUES (%s, %s, %s, %s, %s, %s)", secure($_POST['default']), secure($_POST['enabled']), secure($_POST['country_code']), secure($_POST['country_name']), secure($_POST['phone_code']), secure($_POST['country_order'], 'int'))) or _error("SQL_ERROR_THROWEN");
      /* return */
      return_json(array('callback' => 'window.location = "' . $system['system_url'] . '/' . $control_panel['url'] . '/countries";'));
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
