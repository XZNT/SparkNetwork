<?php


// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true, true);

try {

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
  /* check if user has subscribed to this package before */
  if ($user->_data['user_free_tried']) {
    modal("ERROR", __("Sorry"), __("You already subscribed to this free trial package, Please select different package"));
  }
  /* check if this package not free */
  if ($package['price'] != 0) {
    modal("ERROR", __("Error"), __("Sorry this package is not free!"));
  }

  // update user package
  $user->update_user_package($package['package_id'], $package['name'], $package['price'], $package['verification_badge_enabled']);

  // return
  return_json(array('callback' => 'window.location.href = "' . $system['system_url'] . '/upgraded";'));
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
