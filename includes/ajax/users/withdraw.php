<?php
// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true);

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

try {

  switch ($_GET['type']) {
    case 'wallet':
      // check if wallet enabled
      if (!$system['wallet_enabled'] || !$system['wallet_withdrawal_enabled']) {
        throw new Exception(__("This feature has been disabled by the admin"));
      }

      // valid inputs
      /* valid amount */
      if (is_empty($_POST['amount']) || !is_numeric($_POST['amount']) || $_POST['amount'] <= 0) {
        throw new Exception(__("You have to enter valid amount"));
      }
      if ($_POST['amount'] < $system['wallet_min_withdrawal']) {
        throw new Exception(__("Your balance is less than the minimum withdrawal request amount"));
      }
      if ($_POST['amount'] > $user->_data['user_wallet_balance']) {
        throw new Exception(__("Your balance is less than the requested amount"));
      }
      /* valid method */
      if (!isset($_POST['method']) || !in_array($_POST['method'], $system['wallet_payment_method_array'])) {
        throw new Exception(__("Please select a valid payment method"));
      }
      switch ($_POST['method']) {
        case 'paypal':
        case 'skrill':
          if (!valid_email($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid email address"));
          }
          break;

        case 'bank':
          if (is_empty($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid bank account details"));
          }
          break;

        default:
          if (is_empty($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid transfer to details"));
          }
          break;
      }

      // process
      /* insert payment */
      $db->query(sprintf("INSERT INTO wallet_payments (user_id, amount, method, method_value, time, status) VALUES (%s, %s, %s, %s, %s, '0')", secure($user->_data['user_id'], 'int'), secure($_POST['amount']), secure($_POST['method']), secure($_POST['method_value']), secure($date))) or _error("SQL_ERROR_THROWEN");
      /* update user balance*/
      $db->query(sprintf("UPDATE users SET user_wallet_balance = user_wallet_balance - %s WHERE user_id = %s", secure($_POST['amount']), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      /* wallet transaction */
      $user->wallet_set_transaction($user->_data['user_id'], 'withdraw_wallet', 0, $_POST['amount'], 'out');

      // send notification to admins
      $user->notify_system_admins("wallet_withdrawal");
      break;

    case 'affiliates':
      // check if affiliates enabled
      if (!$system['affiliates_enabled'] || !$system['affiliates_money_withdraw_enabled']) {
        throw new Exception(__("This feature has been disabled by the admin"));
      }

      // valid inputs
      /* valid amount */
      if (is_empty($_POST['amount']) || !is_numeric($_POST['amount']) || $_POST['amount'] <= 0) {
        throw new Exception(__("You have to enter valid amount"));
      }
      if ($_POST['amount'] < $system['affiliates_min_withdrawal']) {
        throw new Exception(__("Your balance is less than the minimum withdrawal request amount"));
      }
      if ($_POST['amount'] > $user->_data['user_affiliate_balance']) {
        throw new Exception(__("Your balance is less than the requested amount"));
      }
      /* valid method */
      if (!isset($_POST['method']) || !in_array($_POST['method'], $system['affiliate_payment_method_array'])) {
        throw new Exception(__("Please select a valid payment method"));
      }
      switch ($_POST['method']) {
        case 'paypal':
        case 'skrill':
          if (!valid_email($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid email address"));
          }
          break;

        case 'bank':
          if (is_empty($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid bank account details"));
          }
          break;

        default:
          if (is_empty($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid transfer to details"));
          }
          break;
      }

      // process
      /* insert payment */
      $db->query(sprintf("INSERT INTO affiliates_payments (user_id, amount, method, method_value, time, status) VALUES (%s, %s, %s, %s, %s, '0')", secure($user->_data['user_id'], 'int'), secure($_POST['amount']), secure($_POST['method']), secure($_POST['method_value']), secure($date))) or _error("SQL_ERROR_THROWEN");
      /* update user balance*/
      $db->query(sprintf("UPDATE users SET user_affiliate_balance = user_affiliate_balance - %s WHERE user_id = %s", secure($_POST['amount']), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");

      // send notification to admins
      $user->notify_system_admins("affiliates_withdrawal");
      break;

    case 'points':
      // check if points enabled
      if (!$system['points_enabled'] || !$system['points_money_withdraw_enabled']) {
        throw new Exception(__("This feature has been disabled by the admin"));
      }

      // valid inputs
      /* valid amount */
      if (is_empty($_POST['amount']) || !is_numeric($_POST['amount']) || $_POST['amount'] <= 0) {
        throw new Exception(__("You have to enter valid amount"));
      }
      if ($_POST['amount'] < $system['points_min_withdrawal']) {
        throw new Exception(__("The requested amount is less than the minimum withdrawal amount"));
      }
      if ($_POST['amount'] > ((1 / $system['points_per_currency']) * $user->_data['user_points'])) {
        throw new Exception(__("Your balance is less than the requested amount"));
      }
      /* valid method */
      if (!isset($_POST['method']) || !in_array($_POST['method'], $system['points_payment_method_array'])) {
        throw new Exception(__("Please select a valid payment method"));
      }
      switch ($_POST['method']) {
        case 'paypal':
        case 'skrill':
          if (!valid_email($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid email address"));
          }
          break;

        case 'bank':
          if (is_empty($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid bank account details"));
          }
          break;

        default:
          if (is_empty($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid transfer to details"));
          }
          break;
      }

      // process
      /* insert payment */
      $db->query(sprintf("INSERT INTO points_payments (user_id, amount, method, method_value, time, status) VALUES (%s, %s, %s, %s, %s, '0')", secure($user->_data['user_id'], 'int'), secure($_POST['amount']), secure($_POST['method']), secure($_POST['method_value']), secure($date))) or _error("SQL_ERROR_THROWEN");
      /* update user balance*/
      $balance = $user->_data['user_points'] - ($system['points_per_currency'] * $_POST['amount']);
      $db->query(sprintf("UPDATE users SET user_points = %s WHERE user_id = %s", secure($balance), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");

      // send notification to admins
      $user->notify_system_admins("points_withdrawal");
      break;

    case 'funding':
      // check if funding enabled
      if (!$user->_data['can_raise_funding'] || !$system['funding_money_withdraw_enabled']) {
        throw new Exception(__("This feature has been disabled by the admin"));
      }

      // valid inputs
      /* valid amount */
      if (is_empty($_POST['amount']) || !is_numeric($_POST['amount']) || $_POST['amount'] <= 0) {
        throw new Exception(__("You have to enter valid amount"));
      }
      if ($_POST['amount'] < $system['funding_min_withdrawal']) {
        throw new Exception(__("The requested amount is less than the minimum withdrawal amount"));
      }
      if ($_POST['amount'] > $user->_data['user_funding_balance']) {
        throw new Exception(__("Your balance is less than the requested amount"));
      }
      /* valid method */
      if (!isset($_POST['method']) || !in_array($_POST['method'], $system['funding_payment_method_array'])) {
        throw new Exception(__("Please select a valid payment method"));
      }
      switch ($_POST['method']) {
        case 'paypal':
        case 'skrill':
          if (!valid_email($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid email address"));
          }
          break;

        case 'bank':
          if (is_empty($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid bank account details"));
          }
          break;

        default:
          if (is_empty($_POST['method_value'])) {
            throw new Exception(__("Please enter a valid transfer to details"));
          }
          break;
      }

      // process
      /* insert payment */
      $db->query(sprintf("INSERT INTO funding_payments (user_id, amount, method, method_value, time, status) VALUES (%s, %s, %s, %s, %s, '0')", secure($user->_data['user_id'], 'int'), secure($_POST['amount']), secure($_POST['method']), secure($_POST['method_value']), secure($date))) or _error("SQL_ERROR_THROWEN");
      /* update user balance*/
      $db->query(sprintf("UPDATE users SET user_funding_balance = user_funding_balance - %s WHERE user_id = %s", secure($_POST['amount']), secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR_THROWEN");

      // send notification to admins
      $user->notify_system_admins("funding_withdrawal");
      break;

    default:
      _error(403);
      break;
  }

  // return
  return_json(array('success' => true, 'message' => __("Your withdrawal request has been sent")));
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
