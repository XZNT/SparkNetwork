<?php

// fetch bootloader
require('bootloader.php');

// check if contact enabled
if (!$system['contact_enabled']) {
  _error(404);
}

// page header
page_header(__($system['system_title']) . ' - ' . __("Contact Us"));

// page footer
page_footer("contact");
