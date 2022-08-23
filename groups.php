<?php
// fetch bootloader
require('bootloader.php');

// groups enabled
if (!$system['groups_enabled']) {
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
      page_header(__("Discover Groups"));

      // get new groups
      $groups = $user->get_groups(array('suggested' => true));
      /* assign variables */
      $smarty->assign('groups', $groups);
      $smarty->assign('get', "suggested_groups");
      break;

    case 'joined':
      // user access
      user_access();

      // page header
      page_header(__("Joined Groups"));

      // get joined groups
      $groups = $user->get_groups(array('user_id' => $user->_data['user_id']));
      /* assign variables */
      $smarty->assign('groups', $groups);
      $smarty->assign('get', "joined_groups");
      break;

    case 'manage':
      // user access
      user_access();

      // page header
      page_header(__("Your Groups"));

      // get managed groups
      $groups = $user->get_groups();
      /* assign variables */
      $smarty->assign('groups', $groups);
      $smarty->assign('get', "groups");
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
page_footer("groups");
