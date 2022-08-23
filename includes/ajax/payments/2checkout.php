<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true, true);

// check if 2Checkout enabled
if (!$system['2checkout_enabled']) {
  modal("MESSAGE", __("Error"), __("This feature has been disabled by the admin"));
}

try {

  switch ($_POST['handle']) {
    case 'packages':
      // valid inputs
      if (!isset($_POST['token'])) {
        _error(400);
      }
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }

      // check package
      $package = $user->get_package($_POST['id']);
      if (!$package) {
        _error(400);
      }
      /* check if user already subscribed to this package */
      if ($user->_data['user_subscribed'] && $user->_data['user_package'] == $package['id']) {
        modal("SUCCESS", __("Subscribed"), __("You already subscribed to this package, Please select different package"));
      }

      // process
      Twocheckout::privateKey($system['2checkout_private_key']);
      Twocheckout::sellerId($system['2checkout_merchant_code']);
      if ($system['2checkout_mode'] == 'sandbox') {
        Twocheckout::verifySSL(false);
      }
      $twocheckout_config = array(
        "merchantOrderId" => get_hash_token(),
        "token" => $_POST['token'],
        "currency" => $system['system_currency'],
        "total" => $package['price'],
        "billingAddr" => array(
          "name" => $_POST['billing_name'],
          "addrLine1" => $_POST['billing_address'],
          "city" => $_POST['billing_city'],
          "state" => $_POST['billing_state'],
          "zipCode" => $_POST['billing_zip_code'],
          "country" => $_POST['billing_country'],
          "email" => $_POST['billing_email'],
          "phoneNumber" => $_POST['billing_phone']
        )
      );
      if ($system['2checkout_mode'] == 'sandbox') {
        $twocheckout_config['demo'] = true;
      }
      $charge = Twocheckout_Charge::auth($twocheckout_config);
      if ($charge['response']['responseCode'] == 'APPROVED') {
        // update user package
        $user->update_user_package($package['id'], $package['name'], $package['price'], $package['verification_badge_enabled']);
      } else {
        return_json(array('error' => true, 'message' => __("Payment Declined: Please verify your information and try again, or try another payment method")));
      }

      // return
      return_json(array('callback' => 'window.location.href = "' . $system['system_url'] . '/upgraded";'));
      break;

    case 'wallet':
      // valid inputs
      if (!isset($_POST['token'])) {
        _error(400);
      }
      if (!isset($_POST['price']) || !is_numeric($_POST['price'])) {
        _error(400);
      }

      // process
      Twocheckout::privateKey($system['2checkout_private_key']);
      Twocheckout::sellerId($system['2checkout_merchant_code']);
      if ($system['2checkout_mode'] == 'sandbox') {
        Twocheckout::verifySSL(false);
      }
      $twocheckout_config = array(
        "merchantOrderId" => get_hash_token(),
        "token" => $_POST['token'],
        "currency" => $system['system_currency'],
        "total" => $_POST['price'],
        "billingAddr" => array(
          "name" => $_POST['billing_name'],
          "addrLine1" => $_POST['billing_address'],
          "city" => $_POST['billing_city'],
          "state" => $_POST['billing_state'],
          "zipCode" => $_POST['billing_zip_code'],
          "country" => $_POST['billing_country'],
          "email" => $_POST['billing_email'],
          "phoneNumber" => $_POST['billing_phone']
        )
      );
      if ($system['2checkout_mode'] == 'sandbox') {
        $twocheckout_config['demo'] = true;
      }
      $charge = Twocheckout_Charge::auth($twocheckout_config);
      if ($charge['response']['responseCode'] == 'APPROVED') {
        // update user wallet balance
        $_SESSION['wallet_replenish_amount'] = $_POST['price'];
        $db->query(sprintf("UPDATE users SET user_wallet_balance = user_wallet_balance + %s WHERE user_id = %s", secure($_SESSION['wallet_replenish_amount']), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");
        /* wallet transaction */
        $user->wallet_set_transaction($user->_data['user_id'], 'recharge', 0, $_SESSION['wallet_replenish_amount'], 'in');
      } else {
        return_json(array('error' => true, 'message' => __("Payment Declined: Please verify your information and try again, or try another payment method")));
      }

      // return
      return_json(array('callback' => 'window.location.href = "' . $system['system_url'] . '/wallet?replenish_succeed";'));
      break;

    case 'donate':
      // valid inputs
      if (!isset($_POST['token'])) {
        _error(400);
      }
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      if (!isset($_POST['price']) || !is_numeric($_POST['price'])) {
        _error(400);
      }

      // process
      Twocheckout::privateKey($system['2checkout_private_key']);
      Twocheckout::sellerId($system['2checkout_merchant_code']);
      if ($system['2checkout_mode'] == 'sandbox') {
        Twocheckout::verifySSL(false);
      }
      $twocheckout_config = array(
        "merchantOrderId" => get_hash_token(),
        "token" => $_POST['token'],
        "currency" => $system['system_currency'],
        "total" => $_POST['price'],
        "billingAddr" => array(
          "name" => $_POST['billing_name'],
          "addrLine1" => $_POST['billing_address'],
          "city" => $_POST['billing_city'],
          "state" => $_POST['billing_state'],
          "zipCode" => $_POST['billing_zip_code'],
          "country" => $_POST['billing_country'],
          "email" => $_POST['billing_email'],
          "phoneNumber" => $_POST['billing_phone']
        )
      );
      if ($system['2checkout_mode'] == 'sandbox') {
        $twocheckout_config['demo'] = true;
      }
      $charge = Twocheckout_Charge::auth($twocheckout_config);
      if ($charge['response']['responseCode'] == 'APPROVED') {
        /* funding donation */
        $user->funding_donation($_POST['id'], $_POST['price']);
      } else {
        return_json(array('error' => true, 'message' => __("Payment Declined: Please verify your information and try again, or try another payment method")));
      }

      // return
      return_json(array('callback' => 'window.location.href = "' . $system['system_url'] . '/posts/' . $_POST['id'] . '";'));
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
