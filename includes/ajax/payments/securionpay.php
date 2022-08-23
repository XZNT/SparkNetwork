<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true, true);

// check if SecurionPay enabled
if (!$system['securionpay_enabled']) {
  modal("MESSAGE", __("Error"), __("This feature has been disabled by the admin"));
}

try {

  switch ($_POST['do']) {
    case 'token':

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

          // get securionpay token
          $token = securionpay($package['price']);
          break;

        case 'wallet':
          // valid inputs
          if (!isset($_POST['price']) || !is_numeric($_POST['price'])) {
            _error(400);
          }

          // get securionpay token
          $token = securionpay($_POST['price']);
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

          // get securionpay token
          $token = securionpay($_POST['price']);
          break;

        default:
          _error(400);
          break;
      }

      // return & exit
      return_json(array('token' => $token));
      break;

    case 'verifiy':

      switch ($_POST['handle']) {
        case 'packages':
          // valid inputs
          if (!isset($_POST['securionpay']['charge']['id'])) {
            _error(400);
          }
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

          // check payment
          $payment = securionpay_check($_POST['securionpay']['charge']['id']);
          if ($payment) {
            /* update user package */
            $user->update_user_package($package['package_id'], $package['name'], $package['price'], $package['verification_badge_enabled']);
          }

          // return
          return_json(array('callback' => 'window.location.href = "' . $system['system_url'] . '/upgraded";'));
          break;

        case 'wallet':
          // valid inputs
          if (!isset($_POST['securionpay']['charge']['id'])) {
            _error(400);
          }
          if (!isset($_POST['price']) || !is_numeric($_POST['price'])) {
            _error(400);
          }

          // check payment
          $payment = securionpay_check($_POST['securionpay']['charge']['id']);
          if ($payment) {
            $_SESSION['wallet_replenish_amount'] = $_POST['price'];
            /* update user wallet balance */
            $db->query(sprintf("UPDATE users SET user_wallet_balance = user_wallet_balance + %s WHERE user_id = %s", secure($_SESSION['wallet_replenish_amount']), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");
            /* wallet transaction */
            $user->wallet_set_transaction($user->_data['user_id'], 'recharge', 0, $_SESSION['wallet_replenish_amount'], 'in');
          }

          // return
          return_json(array('callback' => 'window.location.href = "' . $system['system_url'] . '/wallet?replenish_succeed";'));
          break;

        case 'donate':
          // valid inputs
          if (!isset($_POST['securionpay']['charge']['id'])) {
            _error(400);
          }
          if (!isset($_POST['post_id']) || !is_numeric($_POST['post_id'])) {
            _error(400);
          }
          if (!isset($_POST['price']) || !is_numeric($_POST['price'])) {
            _error(400);
          }

          // check payment
          $payment = securionpay_check($_POST['securionpay']['charge']['id']);
          if ($payment) {
            $_SESSION['donation_amount'] = $_POST['price'];
            /* funding donation */
            $user->funding_donation($_POST['post_id'], $_SESSION['donation_amount']);
          }

          // return
          return_json(array('callback' => 'window.location.href = "' . $system['system_url'] . '/posts/' . $_POST['post_id'] . '";'));
          break;

        default:
          _error(400);
          break;
      }
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
