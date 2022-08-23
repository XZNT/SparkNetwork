<?php
require('bootstrap.php');
if (!isset($_GET['code'])) {
  _error(404);
}
if (!$user->_logged_in) {
  user_login();
}
try {
  $user->activation_email($_GET['code']);
  redirect();
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}
