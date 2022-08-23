<?php
// fetch bootloader
require('bootloader.php');

// check if wallet enabled
if (!$system['wallet_enabled']) {
  _error(404);
}

// user access
user_access();

try {

  // get view content
  switch ($_GET['view']) {
    case '':
      // page header
      page_header(__($system['system_title']) . ' - ' . __("Wallet"));

      // get wallet notifications
      if (isset($_GET['transfer_succeed']) && isset($_SESSION['wallet_transfer_amount'])) {
        /* assign variables */
        $smarty->assign('wallet_transfer_amount', $_SESSION['wallet_transfer_amount']);
        /* unset session */
        unset($_SESSION['wallet_transfer_amount']);
      }
      if (isset($_GET['replenish_succeed']) && isset($_SESSION['wallet_replenish_amount'])) {
        /* assign variables */
        $smarty->assign('wallet_replenish_amount', $_SESSION['wallet_replenish_amount']);
        /* unset session */
        unset($_SESSION['wallet_replenish_amount']);
      }
      if (isset($_GET['withdraw_affiliates_succeed']) && isset($_SESSION['wallet_withdraw_affiliates_amount'])) {
        /* assign variables */
        $smarty->assign('wallet_withdraw_affiliates_amount', $_SESSION['wallet_withdraw_affiliates_amount']);
        /* unset session */
        unset($_SESSION['wallet_withdraw_affiliates_amount']);
      }
      if (isset($_GET['withdraw_points_succeed']) && isset($_SESSION['wallet_withdraw_points_amount'])) {
        /* assign variables */
        $smarty->assign('wallet_withdraw_points_amount', $_SESSION['wallet_withdraw_points_amount']);
        /* unset session */
        unset($_SESSION['wallet_withdraw_points_amount']);
      }
      if (isset($_GET['withdraw_funding_succeed']) && isset($_SESSION['wallet_withdraw_funding_amount'])) {
        /* assign variables */
        $smarty->assign('wallet_withdraw_funding_amount', $_SESSION['wallet_withdraw_funding_amount']);
        /* unset session */
        unset($_SESSION['wallet_withdraw_funding_amount']);
      }
      if (isset($_GET['package_payment_succeed']) && isset($_SESSION['wallet_package_payment_amount'])) {
        /* assign variables */
        $smarty->assign('wallet_package_payment_amount', $_SESSION['wallet_package_payment_amount']);
        /* unset session */
        unset($_SESSION['wallet_package_payment_amount']);
      }

      // get wallet transactions
      $transactions = $user->wallet_get_transactions();
      /* assign variables */
      $smarty->assign('transactions', $transactions);
      break;

    case 'payments':
      // check if wallet withdrawal enabled
      if (!$system['wallet_withdrawal_enabled']) {
        _error(404);
      }

      // page header
      page_header(__($system['system_title']) . ' - ' . __("Wallet Payments"));

      // get payments
      $payments = array();
      $get_payments = $db->query(sprintf('SELECT * FROM wallet_payments WHERE user_id = %s', secure($user->_data['user_id'], 'int'))) or _error("SQL_ERROR");
      if ($get_payments->num_rows > 0) {
        while ($payment = $get_payments->fetch_assoc()) {
          $payments[] = $payment;
        }
      }
      /* assign variables */
      $smarty->assign('payments', $payments);
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
page_footer("wallet");
