<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true, true);

// check if CoinPayments enabled
if (!$system['coinpayments_enabled']) {
  modal("MESSAGE", __("Error"), __("This feature has been disabled by the admin"));
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

      // get coinpayments IPN form
      $coinpayments_form = $user->coinpayments("packages", $package['price'], $package['package_id'], $package['name']);
      break;

    case 'wallet':
      // valid inputs
      if (!isset($_POST['price']) || !is_numeric($_POST['price'])) {
        _error(400);
      }

      // get coinpayments IPN form
      $coinpayments_form = $user->coinpayments("wallet", $_POST['price']);
      break;

    case 'donate':
      // valid inputs
      if (!isset($_POST['post_id']) || !is_numeric($_POST['post_id'])) {
        _error(400);
      }
      if (!isset($_POST['price']) || !is_numeric($_POST['price'])) {
        _error(400);
      }

      // get post
      $post = $user->get_post($_POST['post_id']);
      if (!$post) {
        _error(400);
      }

      // get coinpayments IPN form
      $coinpayments_form = $user->coinpayments("donate", $_POST['price'], $_POST['post_id']);
      break;

    default:
      _error(400);
      break;
  }

  // return & exit
  return_json(array('coinpayments_form' => $coinpayments_form));
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
