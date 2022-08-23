<?php
// fetch bootloader
require('bootloader.php');

// user access
user_access();

try {

  // get view content
  switch ($_GET['view']) {
    case '':
      // page header
      page_header(__("Discover People"));

      // get new people
      $smarty->assign('people', $user->get_new_people());
      break;

    case 'find':
      // page header
      page_header(__("Find People"));

      // valid inputs
      if (!isset($_POST['submit'])) {
        redirect('/people');
      }

      // search users
      $people = $user->search_users($_POST['distance_value'], $_POST['query'], $_POST['gender'], $_POST['relationship'], $_POST['status']);
      $smarty->assign('people', $people);
      break;

    case 'friend_requests':
      // page header
      page_header(__("Friend Requests"));
      break;

    case 'sent_requests':
      // page header
      page_header(__("Friend Requests Sent"));

      // get friend requests sent
      $user->_data['friend_requests_sent'] = $user->get_friend_requests_sent();
      break;

    default:
      _error(404);
      break;
  }
  /* assign variables */
  $smarty->assign('view', $_GET['view']);

  // get total friend requests sent
  $user->_data['friend_requests_sent_total'] = $user->get_friend_requests_sent_total();

  // get genders
  $smarty->assign('genders', $user->get_genders());

  // get custom fields
  $smarty->assign('custom_fields', $user->get_custom_fields(["get" => "search"]));

  // get ads campaigns
  $smarty->assign('ads_campaigns', $user->ads_campaigns());

  // get ads
  $smarty->assign('ads', $user->ads('people'));

  // get widgets
  $smarty->assign('widgets', $user->widgets('people'));
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer("people");
