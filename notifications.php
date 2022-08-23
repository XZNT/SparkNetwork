<?php
// fetch bootloader
require('bootloader.php');

// user access
user_access();

// page header
page_header(__("Notifications"));

try {

  // reset real-time counters
  $user->reset_realtime_counters('notifications');

  // get ads campaigns
  $ads_campaigns = $user->ads_campaigns();
  /* assign variables */
  $smarty->assign('ads_campaigns', $ads_campaigns);

  // get ads
  $ads = $user->ads('notifications');
  /* assign variables */
  $smarty->assign('ads', $ads);

  // get widgets
  $widgets = $user->widgets('notifications');
  /* assign variables */
  $smarty->assign('widgets', $widgets);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer("notifications");
