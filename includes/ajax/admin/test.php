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

// handle test
try {

  switch ($_POST['handle']) {
    case 'smtp':
      /* test */
      email_smtp_test();
      /* return */
      return_json(array('success' => true, 'message' => __("Test email has been sent to") . ": " . $system['system_email']));
      break;

    case 'sms':
      /* test */
      sms_test();
      /* return */
      return_json(array('success' => true, 'message' => __("Test SMS has been sent to") . ": " . $system['system_phone']));
      break;

    case 'google_vision':
      /* test */
      google_vision_test();
      /* return */
      return_json(array('success' => true, 'message' => __("Connection established Successfully!")));
      break;

    case 's3':
      /* test */
      aws_s3_test($system['s3_bucket'], $system['s3_region'], $system['s3_key'], $system['s3_secret']);
      /* return */
      return_json(array('success' => true, 'message' => __("Connection established Successfully!")));
      break;

    case 's3-agora':
      /* test */
      aws_s3_test($system['agora_s3_bucket'], $system['agora_s3_region'], $system['agora_s3_key'], $system['agora_s3_secret']);
      /* return */
      return_json(array('success' => true, 'message' => __("Connection established Successfully!")));
      break;

    case 'digitalocean':
      /* test */
      digitalocean_space_test();
      /* return */
      return_json(array('success' => true, 'message' => __("Connection established Successfully!")));
      break;

    case 'wasabi':
      /* test */
      wasabi_test($system['wasabi_bucket'], $system['wasabi_region'], $system['wasabi_key'], $system['wasabi_secret']);
      /* return */
      return_json(array('success' => true, 'message' => __("Connection established Successfully!")));
      break;

    case 'google_cloud':
      /* test */
      google_cloud_test($system['google_cloud_bucket'], $system['google_cloud_file']);
      /* return */
      return_json(array('success' => true, 'message' => __("Connection established Successfully!")));
      break;

    case 'ftp':
      /* test */
      ftp_test();
      /* return */
      return_json(array('success' => true, 'message' => __("Connection established Successfully!")));
      break;

    default:
      _error(400);
      break;
  }
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
