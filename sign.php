<?php
// fetch bootloader
require('bootloader.php');

switch ($_GET['do']) {
  case 'in':
    // check user logged in
    if ($user->_logged_in) {
      redirect();
    }

    // page header
    page_header(__($system['system_title']) . " &rsaquo; " . __("Login"));

    // get genders
    $smarty->assign('genders', $user->get_genders());

    // get countries
    $smarty->assign('countries', $user->get_countries());

    // get custom fields
    $smarty->assign('custom_fields', $user->get_custom_fields());

    // assign varible
    $smarty->assign('do', $_GET['do']);

    // page footer
    page_footer("sign");
    break;

  case 'up':
    // check user logged in
    if ($user->_logged_in) {
      header('Location: ' . $system['system_url']);
    }

    // check if registration enabled
    if (!$system['registration_enabled']) {
      _error(404);
    }

    // page header
    page_header(__($system['system_title']) . " &rsaquo; " . __("Sign Up"));

    // get genders
    $smarty->assign('genders', $user->get_genders());

    // get countries
    $smarty->assign('countries', $user->get_countries());

    // get custom fields
    $smarty->assign('custom_fields', $user->get_custom_fields());

    // get invitation code
    if ($system['invitation_enabled'] && isset($_GET['invitation_code'])) {
      $smarty->assign('invitation_code', htmlentities($_GET['invitation_code'], ENT_QUOTES, 'utf-8'));
    }

    // assign varible
    $smarty->assign('do', $_GET['do']);

    // page footer
    page_footer("sign");
    break;

  case 'out':
    // check user logged in
    if (!$user->_logged_in) {
      redirect();
    }

    // sign out
    $user->sign_out();
    redirect();
    break;

  case 'reset':
    // check user logged in
    if ($user->_logged_in) {
      redirect();
    }

    // page header
    page_header(__($system['system_title']) . " &rsaquo; " . __("Forgot your password?"));

    // page footer
    page_footer("reset");
    break;

  default:
    _error(404);
    break;
}
