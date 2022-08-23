<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// check admin|moderator permission
if (!$user->_is_admin) {
  modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
}

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

// handle ads
try {

  switch ($_REQUEST['do']) {
    case 'settings':
      /* prepare */
      $_POST['ads_enabled'] = (isset($_POST['ads_enabled'])) ? '1' : '0';
      $_POST['ads_approval_enabled'] = (isset($_POST['ads_approval_enabled'])) ? '1' : '0';
      /* update */
      update_system_options([
        'ads_enabled' => secure($_POST['ads_enabled']),
        'ads_approval_enabled' => secure($_POST['ads_approval_enabled']),
        'ads_cost_view' => secure($_POST['ads_cost_view']),
        'ads_cost_click' => secure($_POST['ads_cost_click']),
        'ads_permission' => secure($_POST['ads_permission'])
      ]);
      if ($_POST['ads_enabled']) {
        update_system_options([
          'wallet_enabled' => secure($_POST['ads_enabled'])
        ]);
      }
      /* return */
      return_json(array('success' => true, 'message' => __("Ads settings have been updated")));
      break;

    case 'edit':
      /* valid inputs */
      if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
        _error(400);
      }
      /* update */
      $db->query(sprintf("UPDATE ads_system SET title = %s, place = %s, code = %s WHERE ads_id = %s", secure($_POST['title']), secure($_POST['place']), secure($_POST['message']), secure($_GET['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      /* return */
      return_json(array('success' => true, 'message' => __("Ads info have been updated")));
      break;

    case 'add':
      /* insert */
      $db->query(sprintf("INSERT INTO ads_system (title, place, code, time) VALUES (%s, %s, %s, %s)", secure($_POST['title']), secure($_POST['place']), secure($_POST['message']), secure($date))) or _error("SQL_ERROR_THROWEN");
      /* return */
      return_json(array('callback' => 'window.location = "' . $system['system_url'] . '/' . $control_panel['url'] . '/ads/system_ads";'));
      break;

    case 'approve':
      /* get the campaign */
      $campaign = $user->get_campaign($_POST['id']);
      if (!$campaign) {
        _error(400);
      }
      /* approve campaign */
      $db->query(sprintf("UPDATE ads_campaigns SET campaign_is_approved = '1' WHERE campaign_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      /* notify the user */
      $user->post_notification(array('to_user_id' => $campaign['campaign_user_id'], 'action' => 'ads_campaign_approved'));
      /* return */
      return_json();
      break;

    case 'decline':
      /* get the campaign */
      $campaign = $user->get_campaign($_POST['id']);
      if (!$campaign) {
        _error(400);
      }
      /* decline campaign */
      $db->query(sprintf("UPDATE ads_campaigns SET campaign_is_declined = '1' WHERE campaign_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      /* notify the user */
      $user->post_notification(array('to_user_id' => $campaign['campaign_user_id'], 'action' => 'ads_campaign_declined'));
      /* return */
      return_json();
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
