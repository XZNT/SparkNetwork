<?php
// fetch bootloader
require('bootloader.php');

// check if packages enabled
if (!$system['packages_enabled']) {
  _error(404);
}

try {

  switch ($_GET['view']) {
    case 'packages':
      // page header
      page_header(__($system['system_title']) . " &rsaquo; " . __("Packages"));

      // get packages
      $packages = $user->get_packages();
      /* assign variables */
      $smarty->assign('packages', $packages);
      $smarty->assign('packages_count', count($packages));
      break;

    case 'upgraded':
      // page header
      page_header(__($system['system_title']) . " &rsaquo; " . __("Congratulation"));

      if (!$user->_data['user_subscribed']) {
        redirect("/packages");
      }
      break;

    default:
      _error(404);
      break;
  }
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// assign varible
$smarty->assign('view', $_GET['view']);

// page footer
page_footer("packages");
