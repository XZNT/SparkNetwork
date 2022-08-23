<?php
require('bootloader.php');

// check if ads enabled
if (!$system['ads_enabled']) {
  _error(404);
}

// user access
user_access();

try {

  // get view content
  switch ($_GET['view']) {
    case '':
      // page header
      page_header(__($system['system_title']) . ' - ' . __("Ads Manager"));

      // get campaigns
      $campaigns = $user->get_campaigns();
      /* assign variables */
      $smarty->assign('campaigns', $campaigns);
      break;

    case 'new':
      // page header
      page_header(__("New Campaign"));

      // get viewer all managed pages
      $pages = $user->get_pages(array('managed' => true, 'user_id' => $user->_data['user_id']));
      /* assign variables */
      $smarty->assign('pages', $pages);

      // get viewer all managed groups
      $groups = $user->get_groups(array('managed' => true, 'user_id' => $user->_data['user_id']));
      /* assign variables */
      $smarty->assign('groups', $groups);

      // get viewer all managed events
      $events = $user->get_events(array('managed' => true, 'user_id' => $user->_data['user_id']));
      /* assign variables */
      $smarty->assign('events', $events);

      // get genders
      $genders = $user->get_genders();
      /* assign variables */
      $smarty->assign('genders', $genders);

      // get countries if 2checkout is disabled
      if (!$system['2checkout_enabled']) {
        $countries = $user->get_countries();
        /* assign variables */
        $smarty->assign('countries', $countries);
      }

      // get campaign potential reach
      $potential_reach = $user->campaign_potential_reach();
      /* assign variables */
      $smarty->assign('potential_reach', $potential_reach);
      break;

    case 'edit':
      // page header
      page_header(__("Edit Campaign"));

      // get campaign
      $campaign = $user->get_campaign($_GET['campaign_id']);
      if (!$campaign) {
        _error(404);
      }
      /* check permission */
      if (!($user->_data['user_group'] < 3 || $user->_data['user_id'] == $campaign['campaign_user_id'])) {
        _error(404);
      }
      /* assign variables */
      $smarty->assign('campaign', $campaign);

      // get target all managed pages
      $pages = $user->get_pages(array('managed' => true, 'user_id' => $campaign['campaign_user_id']));
      /* assign variables */
      $smarty->assign('pages', $pages);

      // get target all managed groups
      $groups = $user->get_groups(array('managed' => true, 'user_id' => $campaign['campaign_user_id']));
      /* assign variables */
      $smarty->assign('groups', $groups);

      // get target all managed events
      $events = $user->get_events(array('managed' => true, 'user_id' => $campaign['campaign_user_id']));
      /* assign variables */
      $smarty->assign('events', $events);

      // get genders
      $genders = $user->get_genders();
      /* assign variables */
      $smarty->assign('genders', $genders);

      // get countries if 2checkout is disabled
      if (!$system['2checkout_enabled']) {
        $countries = $user->get_countries();
        /* assign variables */
        $smarty->assign('countries', $countries);
      }
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
page_footer("ads");
