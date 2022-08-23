<?php
// fetch bootloader
require('bootloader.php');

// pages enabled
if (!$system['pages_enabled']) {
  _error(404);
}

try {

  // get view content
  switch ($_GET['view']) {
    case '':
      // user access
      if ($user->_logged_in || !$system['system_public']) {
        user_access();
      }

      // page header
      page_header(__("Discover Pages"));

      // get new pages
      $pages = $user->get_pages(array('suggested' => true));
      /* assign variables */
      $smarty->assign('pages', $pages);
      $smarty->assign('get', "suggested_pages");

      break;

    case 'liked':
      // user access
      user_access();

      // page header
      page_header(__("Liked Pages"));

      // get liked pages
      $pages = $user->get_pages(array('user_id' => $user->_data['user_id']));
      /* assign variables */
      $smarty->assign('pages', $pages);
      $smarty->assign('get', "liked_pages");

      break;

    case 'manage':
      // user access
      user_access();

      // page header
      page_header(__("Your Pages"));

      // get managed pages
      $pages = $user->get_pages();
      /* assign variables */
      $smarty->assign('pages', $pages);
      $smarty->assign('get', "pages");

      break;

    default:
      _error(404);
      break;
  }
  /* assign variables */
  $smarty->assign('view', $_GET['view']);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer("pages");
