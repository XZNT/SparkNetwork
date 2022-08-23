<?php
// fetch bootloader
require('bootloader.php');

// live enabled
if (!$system['live_enabled']) {
  _error(404);
}

// live permission
if (!$user->_data['can_go_live']) {
  _error('PERMISSION');
}

// check demo account
if ($user->_data['user_demo']) {
  _error('PERMISSION');
}

// page header
page_header(__($system['system_title']) . ' - ' . __("Live Video"));

// get agora (uid|token|channel_name)
$agora = $user->agora_token_builder(true);
/* assign variables */
$smarty->assign('agora', $agora);

// set page|group|event id
if (isset($_GET['page_id']) && is_numeric($_GET['page_id'])) {
  /* assign variables */
  $smarty->assign('page_id', $_GET['page_id']);
}
if (isset($_GET['group_id']) && is_numeric($_GET['group_id'])) {
  /* assign variables */
  $smarty->assign('group_id', $_GET['group_id']);
}
if (isset($_GET['event_id']) && is_numeric($_GET['event_id'])) {
  /* assign variables */
  $smarty->assign('event_id', $_GET['event_id']);
}

// page footer
page_footer("live");
