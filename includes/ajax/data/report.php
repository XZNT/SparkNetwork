<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true);

// valid inputs
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
  _error(400);
}
if (!isset($_GET['handle'])) {
  _error(400);
}

try {

  // initialize the return array
  $return = array();

  switch ($_REQUEST['do']) {
    case 'create':
      // get report categories
      $smarty->assign('categories', $user->get_categories("reports_categories"));

      // get id & handle
      $smarty->assign('id', $_GET['id']);
      $smarty->assign('handle', $_GET['handle']);

      // return
      $return['template'] = $smarty->fetch("ajax.report.publisher.tpl");
      $return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template); initialize_modal();";
      break;

    case 'submit':
      // report
      $user->report($_GET['id'], $_GET['handle'], $_POST['category'], $_POST['reason']);

      // return & exit
      modal("SUCCESS", __("Thanks"), __("Your report has been submitted"));
      break;

    default:
      _error(400);
      break;
  }

  // return & exit
  return_json($return);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
