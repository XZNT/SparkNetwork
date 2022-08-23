<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true, true);

// check if Cashfree enabled
if (!$system['cashfree_enabled']) {
  modal("MESSAGE", __("Error"), __("This feature has been disabled by the admin"));
}

// valid inputs
if (!isset($_POST['billing_name']) || !isset($_POST['billing_email']) || !isset($_POST['billing_phone'])) {
  _error(400);
}

try {

  switch ($_POST['handle']) {
    case 'packages':
      // valid inputs
      if (!isset($_POST['package_id']) || !is_numeric($_POST['package_id'])) {
        _error(400);
      }

      // check package
      $package = $user->get_package($_POST['package_id']);
      if (!$package) {
        _error(400);
      }
      /* check if user already subscribed to this package */
      if ($user->_data['user_subscribed'] && $user->_data['user_package'] == $package['package_id']) {
        modal("SUCCESS", __("Subscribed"), __("You already subscribed to this package, Please select different package"));
      }

      // get cashfree link
      $link = cashfree("packages", $package['price'], $package['package_id'], $_POST['billing_name'], $_POST['billing_email'], $_POST['billing_phone']);
      break;

    case 'wallet':
      // valid inputs
      if (!isset($_POST['price']) || !is_numeric($_POST['price'])) {
        _error(400);
      }

      // get cashfree link
      $link = cashfree("wallet", $_POST['price'], null, $_POST['billing_name'], $_POST['billing_email'], $_POST['billing_phone']);
      break;

    case 'donate':
      // valid inputs
      if (!isset($_POST['post_id']) || !is_numeric($_POST['post_id'])) {
        _error(400);
      }

      // get post
      $post = $user->get_post($_POST['post_id']);
      if (!$post) {
        _error(400);
      }

      // get cashfree link
      $link = cashfree("donate", $_POST['price'], $_POST['post_id'], $_POST['billing_name'], $_POST['billing_email'], $_POST['billing_phone']);
      break;

    default:
      _error(400);
      break;
  }

  // return & exit
  return_json(array('callback' => 'window.location.href = "' . $link . '";'));
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
