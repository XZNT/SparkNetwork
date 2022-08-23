<?php
// fetch bootloader
require('bootloader.php');

// funding enabled
if (!$system['funding_enabled']) {
  _error(404);
}

// user access
if ($user->_logged_in || !$system['system_public']) {
  user_access();
}

try {

  // page header
  page_header(__($system['system_title']) . ' - ' . __("Funding"), __($system['system_description_funding']));

  // get fundings
  $fundings = $user->get_fundings(['results' => 11]); /* using 11 to match the design layout */
  /* assign variables */
  $smarty->assign('fundings', $fundings);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer("funding");
