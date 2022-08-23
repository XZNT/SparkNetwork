<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

try {

  // valid inputs
  if (is_empty($_POST['name']) || is_empty($_POST['email']) || is_empty($_POST['subject']) || is_empty($_POST['message'])) {
    throw new Exception(__("You must fill in all of the fields"));
  }
  if (!valid_email($_POST['email'])) {
    throw new Exception(__("Please enter a valid email address"));
  }
  /* check reCAPTCHA */
  if ($system['reCAPTCHA_enabled']) {
    $recaptcha = new \ReCaptcha\ReCaptcha($system['reCAPTCHA_secret_key']);
    $resp = $recaptcha->verify($_POST['g-recaptcha-response'], get_user_ip());
    if (!$resp->isSuccess()) {
      throw new Exception(__("The security check is incorrect. Please try again"));
    }
  }

  // prepare email
  $subject = "New email message from " . __($system['system_title']);
  $body = get_email_template("contact_form_email", $subject, ["_POST" => $_POST]);

  // send email
  if (!_email($system['system_email'], $subject, $body['html'], $body['plain'])) {
    throw new Exception(__("Your email could not be sent. Please try again later"));
  }

  // return
  return_json(array('success' => true, 'message' => __("Your message has been sent! Thanks a lot and will be back to you soon")));
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
