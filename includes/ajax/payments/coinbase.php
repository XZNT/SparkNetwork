<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true, true);

// check if Coinbase enabled
if (!$system['coinbase_enabled']) {
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

      // get coinbase link
      $coinbase = coinbase("wallet", $_POST['price']);

      // update user
      $db->query(sprintf("UPDATE users SET coinbase_hash = %s, coinbase_code = %s WHERE user_id = %s", secure($coinbase['coinbase_hash']), secure($coinbase['coinbase_code']), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");

      // return link
      $link = $coinbase['hosted_url'];
      break;

    case 'wallet':
      // valid inputs
      if (!isset($_POST['price']) || !is_numeric($_POST['price'])) {
        _error(400);
      }

      // get coinbase link
      $coinbase = coinbase("wallet", $_POST['price']);

      // update user
      $db->query(sprintf("UPDATE users SET coinbase_hash = %s, coinbase_code = %s WHERE user_id = %s", secure($coinbase['coinbase_hash']), secure($coinbase['coinbase_code']), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");

      // return link
      $link = $coinbase['hosted_url'];
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

      // get coinbase link
      $coinbase = coinbase("wallet", $_POST['price']);

      // update user
      $db->query(sprintf("UPDATE users SET coinbase_hash = %s, coinbase_code = %s WHERE user_id = %s", secure($coinbase['coinbase_hash']), secure($coinbase['coinbase_code']), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");

      // return link
      $link = $coinbase['hosted_url'];
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
