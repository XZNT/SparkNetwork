<?php
/* ------------------------------- */
/* Core */
/* ------------------------------- */

/**
 * check_system_requirements
 * 
 * @return array
 */
function check_system_requirements()
{
  /* init errors */
  $errors = [];
  /* set required php version*/
  $required_php_version = '7.1';
  /* check php version */
  if (version_compare($required_php_version, PHP_VERSION, '>=')) {
    $errors['PHP'] = true;
  }
  /* check if mysqli enabled */
  if (!extension_loaded('mysqli') || !function_exists('mysqli_connect')) {
    $errors['mysqli'] = true;
  }
  /* check if curl enabled */
  if (!extension_loaded('curl') || !function_exists('curl_init')) {
    $errors['curl'] = true;
  }
  /* check if mbstring enabled */
  if (!extension_loaded('mbstring')) {
    $errors['mbstring'] = true;
  }
  /* check if gd enabled */
  if (!extension_loaded('gd') || !function_exists('gd_info')) {
    $errors['gd'] = true;
  }
  /* check if mbstring enabled */
  if (!extension_loaded('mbstring')) {
    $errors['mbstring'] = true;
  }
  /* check if zip enabled */
  if (!extension_loaded('zip')) {
    $errors['zip'] = true;
  }
  /* check if allow_url_fopen enabled */
  if (!ini_get('allow_url_fopen')) {
    $errors['allow_url_fopen'] = true;
  }
  /* check if htaccess exist */
  if (!file_exists(ABSPATH . '.htaccess')) {
    $errors['htaccess'] = true;
  }
  /* check if config writable */
  if (!is_writable(ABSPATH . 'includes/config-example.php')) {
    $errors['config'] = true;
  }
  /* return */
  return $errors;
}


/**
 * update_system_options
 * 
 * @param array $args
 * @param boolean $error_thrown
 * @return void
 */
function update_system_options($args = [], $error_thrown = true)
{
  global $db;
  $query_values = "";
  foreach ($args as $key => $value) {
    $query_values .= sprintf(" ('%s', %s),", $key, $value);
  }
  $query_values = substr($query_values, 0, -1);
  $db->query("INSERT INTO system_options (option_name, option_value) VALUES " . $query_values . " ON DUPLICATE KEY UPDATE option_name = VALUES(option_name), option_value = VALUES(option_value)") or ($error_thrown) ? _error("SQL_ERROR_THROWEN") : _error("Error", $db->error);
}


/**
 * get_licence_key
 * 
 * @param string $code
 * @return string
 */
function get_licence_key($code)
{
	//bugs
	return '';
}


/**
 * get_system_protocol
 * 
 * @return string
 */
function get_system_protocol()
{
  $is_secure = false;
  if (isset($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) == 'on') {
    $is_secure = true;
  } elseif (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https' || !empty($_SERVER['HTTP_X_FORWARDED_SSL']) && $_SERVER['HTTP_X_FORWARDED_SSL'] == 'on') {
    $is_secure = true;
  }
  return $is_secure ? 'https' : 'http';
}


/**
 * get_system_url
 * 
 * @return string
 */
function get_system_url()
{
  $protocol = get_system_protocol();
  $system_url =  $protocol . "://" . $_SERVER['HTTP_HOST'] . BASEPATH;
  return rtrim($system_url, '/');
}


/**
 * check_system_url
 * 
 * @return void
 */
function check_system_url()
{
  $protocol = get_system_protocol();
  $parsed_url = parse_url(SYS_URL);
  if (($parsed_url['scheme'] != $protocol) || ($parsed_url['host'] != $_SERVER['HTTP_HOST'])) {
    header('Location: ' . SYS_URL);
  }
}


/**
 * redirect
 * 
 * @param string $url
 * @return void
 */
function redirect($url = '')
{
  if ($url) {
    header('Location: ' . SYS_URL . $url);
  } else {
    header('Location: ' . SYS_URL);
  }
  exit;
}


/**
 * reload
 * 
 * @return void
 */
function reload()
{
  header("Refresh:0");
  exit;
}



/* ------------------------------- */
/* Security */
/* ------------------------------- */

/**
 * secure
 * 
 * @param string $value
 * @param string $type
 * @param boolean $quoted
 * @return string
 */
function secure($value, $type = "", $quoted = true)
{
  global $db;
  if ($value !== 'null') {
    // [1] Sanitize
    /* Convert all applicable characters to HTML entities */
    $value = htmlentities($value, ENT_QUOTES, 'utf-8');
    // [2] Safe SQL
    $value = $db->real_escape_string($value);
    switch ($type) {
      case 'int':
        $value = ($quoted) ? "'" . intval($value) . "'" : intval($value);
        break;
      case 'datetime':
        $value = ($quoted) ? "'" . set_datetime($value) . "'" : set_datetime($value);
        break;
      case 'search':
        if ($quoted) {
          $value = (!is_empty($value)) ? "'%" . $value . "%'" : "''";
        } else {
          $value = (!is_empty($value)) ? "'%%" . $value . "%%'" : "''";
        }
        break;
      default:
        $value = (!is_empty($value)) ? $value : "";
        $value = ($quoted) ? "'" . $value . "'" : $value;
        break;
    }
  }
  return $value;
}


/**
 * session_hash
 * 
 * @param string $hash
 * @return array
 */
function session_hash($hash)
{
	//bugs
}


/**
 * _password_hash
 * 
 * @param string $password
 * @return string
 */
function _password_hash($password)
{
  return password_hash($password, PASSWORD_DEFAULT);
}


/**
 * get_hash_key
 * 
 * @param integer $length
 * @param boolean $only_numbers
 * @return string
 */
function get_hash_key($length = 8, $only_numbers = false)
{
  $chars = ($only_numbers) ? '0123456789' : 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  $count = mb_strlen($chars);
  for ($i = 0, $result = ''; $i < $length; $i++) {
    $index = rand(0, $count - 1);
    $result .= mb_substr($chars, $index, 1);
  }
  return $result;
}


/**
 * get_hash_token
 * 
 * @return string
 */
function get_hash_token()
{
  return md5(get_hash_number());
}


/**
 * get_hash_number
 * 
 * @return string
 */
function get_hash_number()
{
  return time() * rand(1, 99999);
}



/* ------------------------------- */
/* Validation */
/* ------------------------------- */

/**
 * is_ajax
 * 
 * @return void
 */
function is_ajax()
{
  if (!isset($_SERVER['HTTP_X_REQUESTED_WITH']) || ($_SERVER['HTTP_X_REQUESTED_WITH'] != 'XMLHttpRequest')) {
    redirect();
  }
}


/**
 * is_empty
 * 
 * @param string $value
 * @return boolean
 */
function is_empty($value)
{
  if (strlen(trim(preg_replace('/\xc2\xa0/', ' ', $value))) == 0) {
    return true;
  } else {
    return false;
  }
}


/**
 * valid_email
 * 
 * @param string $email
 * @return boolean
 */
function valid_email($email)
{
  if (filter_var($email, FILTER_VALIDATE_EMAIL) !== false) {
    return true;
  } else {
    return false;
  }
}


/**
 * valid_url
 * 
 * @param string $url
 * @return boolean
 */
function valid_url($url)
{
  if (filter_var($url, FILTER_VALIDATE_URL) !== false) {
    return true;
  } else {
    return false;
  }
}


/**
 * valid_username
 * 
 * @param string $username
 * @return boolean
 */
function valid_username($username)
{
  if (strlen($username) >= 3 && preg_match('/^[a-zA-Z0-9]+([_|.]?[a-zA-Z0-9])*$/', $username)) {
    return true;
  } else {
    return false;
  }
}


/**
 * reserved_username
 * 
 * @param string $username
 * @return boolean
 */
function reserved_username($username)
{
  $reserved_usernames = array('install', 'static', 'contact', 'contacts', 'sign', 'signin', 'login', 'signup', 'register', 'signout', 'logout', 'reset', 'activation', 'connect', 'revoke', 'packages', 'started', 'search', 'friends', 'messages', 'message', 'notifications', 'notification', 'settings', 'setting', 'posts', 'post', 'photos', 'photo', 'create', 'pages', 'page', 'groups', 'group', 'events', 'event', 'games', 'game', 'saved', 'forums', 'forum', 'blogs', 'blog', 'articles', 'article', 'directory', 'products', 'product', 'market', 'admincp', 'admin', 'admins', 'modcp', 'moderator', 'moderators', 'moderatorcp', 'chat', 'ads', 'wallet', 'boosted', 'people', 'popular', 'movies', 'movie',  'api', 'apis', 'oauth', 'authorize', 'anonymous', 'jobs', 'job');
  if (in_array(strtolower($username), $reserved_usernames)) {
    return true;
  } else {
    return false;
  }
}


/**
 * valid_name
 * 
 * @param string $name
 * @return boolean
 */
function valid_name($name)
{
  if (!ctype_graph($name) || preg_match('/[[:punct:]]/i', $name) || valid_url($name)) {
    return false;
  }
  return true;
}


/**
 * valid_extension
 * 
 * @param string $extension
 * @param array $allowed_extensions
 * @return boolean
 */
function valid_extension($extension, $allowed_extensions)
{
  $extensions = explode(',', $allowed_extensions);
  foreach ($extensions as $key => $value) {
    $extensions[$key] = strtolower(trim($value));
  }
  if (is_array($extensions) && in_array($extension, $extensions)) {
    return true;
  }
  return false;
}


/**
 * set_extensions_string
 * 
 * @param string $extensions
 * @return string
 */
function set_extensions_string($extensions)
{
  $extensions_string = "";
  $extensions = explode(',', $extensions);
  foreach ($extensions as $key => $value) {
    $extensions_string .= "." . strtolower(trim($value)) . ",";
  }
  $extensions_string = substr($extensions_string, 0, -1);
  return $extensions_string;
}



/* ------------------------------- */
/* Date */
/* ------------------------------- */

/**
 * set_datetime
 * 
 * @param string $date
 * @return string
 */
function set_datetime($date)
{
  global $system;
  $date = str_replace(['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'], range(0, 9), $date); /* check and replace arabic numbers if any */
  $datetime = DateTime::createFromFormat($system['system_datetime_format'], $date);
  return $datetime->format("Y-m-d H:i:s");
}


/**
 * get_datetime
 * 
 * @param string $date
 * @return string
 */
function get_datetime($date)
{
  global $system;
  return date($system['system_datetime_format'], strtotime($date));
}



/* ------------------------------- */
/* JSON */
/* ------------------------------- */

/**
 * return_json
 * 
 * @param array $response
 * @return json
 */
function return_json($response = [])
{
  header('Content-Type: application/json');
  exit(json_encode($response));
}


/**
 * return_json_async
 * 
 * @param array $response
 * @return void
 */
function return_json_async($response = [])
{
  if (!empty(ob_get_status())) {
    ob_end_clean();
    header("Content-Encoding: none");
    header("Connection: close");
    ignore_user_abort();
    ob_start();
    header('Content-Type: application/json');
    echo json_encode($response);
    $size = ob_get_length();
    header("Content-Length: $size");
    ob_end_flush();
    flush();
    session_write_close();
    if (is_callable('fastcgi_finish_request')) {
      fastcgi_finish_request();
    }
  }
}



/* ------------------------------- */
/* Error */
/* ------------------------------- */

/**
 * _error
 * 
 * @return void
 */
function _error()
{
  $args = func_get_args();
  if (count($args) > 1 && $args[0] != "BANNED_USER") {
    $title = $args[0];
    $message = $args[1];
  } else {
    switch ($args[0]) {
      case 'DB_ERROR':
        $title = "Database Error";
        $message = "<div class='text-left'><h1>" . "Error establishing a database connection" . "</h1>
                            <p>" . "This either means that the username and password information in your config.php file is incorrect or we can't contact the database server at localhost. This could mean your host's database server is down." . "</p>
                            <ul>
                                <li>" . "Are you sure you have the correct username and password?" . "</li>
                                <li>" . "Are you sure that you have typed the correct hostname?" . "</li>
                                <li>" . "Are you sure that the database server is running?" . "</li>
                            </ul>
                            <p>" . "If you're unsure what these terms mean you should probably contact your host. If you still need help you can always visit the" . " <a href='https://yruz.one/Zanto'>" . "YRUZ Support" . ".</a></p>
                            </div>";
        break;

      case 'SQL_ERROR':
        $title = __("Database Error");
        $message = __("An error occurred while writing to database. Please try again later");
        if (DEBUGGING) {
          $backtrace = debug_backtrace();
          $line = $backtrace[0]['line'];
          $file = $backtrace[0]['file'];
          $message .= "<br><br><small>This error function was called from line $line in file $file</small>";
        }
        break;

      case 'SQL_ERROR_THROWEN':
        $message = __("An error occurred while writing to database. Please try again later");
        if (DEBUGGING) {
          $backtrace = debug_backtrace();
          $line = $backtrace[0]['line'];
          $file = $backtrace[0]['file'];
          $message .= "<br><br><small>This error function was called from line $line in file $file</small>";
        }
        throw new Exception($message);
        break;

      case 'PERMISSION':
        global $smarty;
        $title = __("Permission Needed");
        $message = __("You do not have the permission to view this content");
        if (isset($smarty)) {
          $smarty->assign('message', $message);
          page_header($title);
          page_footer('permission');
          exit;
        }
        break;

      case 'BANNED':
        global $smarty;
        $title = __("Banned");
        $message = __("You do not have the permission to view this content");
        if (isset($smarty)) {
          $smarty->assign('message', $message);
          page_header($title);
          page_footer('banned');
          exit;
        }
        break;

      case 'BANNED_USER':
        global $smarty;
        $title = __("Banned Account");
        $message = $args[1];
        if (isset($smarty)) {
          $smarty->assign('message', $message);
          page_header($title);
          page_footer('banned');
          exit;
        }
        break;

      case 'activation':
        global $smarty;
        if (isset($smarty)) {
          page_header(__("Activation Required"));
          page_footer('activation');
          exit;
        }
        break;

      case '404':
        global $smarty;
        header('HTTP/1.0 404 Not Found');
        $title = __("404 Not Found");
        $message = __("Sorry but the page you are looking for does not exist, have been removed. name changed or is temporarily unavailable");
        if (DEBUGGING) {
          $backtrace = debug_backtrace();
          $line = $backtrace[0]['line'];
          $file = $backtrace[0]['file'];
          $message .= "<br><br><small>This error function was called from line $line in file $file</small>";
        }
        if (isset($smarty)) {
          $smarty->assign('message', $message);
          page_header($title);
          page_footer('404');
          exit;
        }
        break;

      case '400':
        header('HTTP/1.0 400 Bad Request');
        if (DEBUGGING) {
          $backtrace = debug_backtrace();
          $line = $backtrace[0]['line'];
          $file = $backtrace[0]['file'];
          exit("This error function was called from line $line in file $file");
        }
        exit;
        break;

      case '403':
        header('HTTP/1.0 403 Access Denied');
        if (DEBUGGING) {
          $backtrace = debug_backtrace();
          $line = $backtrace[0]['line'];
          $file = $backtrace[0]['file'];
          exit("This error function was called from line $line in file $file");
        }
        exit;
        break;

      default:
        $title = __("Error");
        $message = __("There is some thing went wrong");
        if (DEBUGGING) {
          $backtrace = debug_backtrace();
          $line = $backtrace[0]['line'];
          $file = $backtrace[0]['file'];
          $message .= "<br><br>" . "<small>This error function was called from line $line in file $file</small>";
        }
        break;
    }
  }
  echo '<!DOCTYPE html>
            <html>
            <head>
                <meta charset="utf-8">
                <title>' . $title . '</title>
                <style type="text/css">
                    html {
                        background: #f1f1f1;
                    }
                    body {
                        color: #555;
                        font-family: "Open Sans", Arial,sans-serif;
                        margin: 0;
                        padding: 0;
                    }
                    .error-title {
                        background: #ce3426;
                        color: #fff;
                        text-align: center;
                        font-size: 34px;
                        font-weight: 100;
                        line-height: 50px;
                        padding: 60px 0;
                    }
                    .error-message {
                        margin: 1em auto;
                        padding: 1em 2em;
                        max-width: 600px;
                        font-size: 1em;
                        line-height: 1.8em;
                        text-align: center;
                    }
                    .error-message .code,
                    .error-message p {
                        margin-top: 0;
                        margin-bottom: 1.3em;
                    }
                    .error-message .code {
                        font-family: Consolas, Monaco, monospace;
                        background: rgba(0, 0, 0, 0.7);
                        padding: 10px;
                        color: rgba(255, 255, 255, 0.7);
                        word-break: break-all;
                        border-radius: 2px;
                    }
                    h1 {
                        font-size: 1.2em;
                    }
                    
                    ul li {
                        margin-bottom: 1em;
                        font-size: 0.9em;
                    }
                    a {
                        color: #ce3426;
                        text-decoration: none;
                    }
                    a:hover {
                        text-decoration: underline;
                    }
                    .button {
                        background: #f7f7f7;
                        border: 1px solid #cccccc;
                        color: #555;
                        display: inline-block;
                        text-decoration: none;
                        margin: 0;
                        padding: 5px 10px;
                        cursor: pointer;
                        -webkit-border-radius: 3px;
                        -webkit-appearance: none;
                        border-radius: 3px;
                        white-space: nowrap;
                        -webkit-box-sizing: border-box;
                        -moz-box-sizing:    border-box;
                        box-sizing:         border-box;

                        -webkit-box-shadow: inset 0 1px 0 #fff, 0 1px 0 rgba(0,0,0,.08);
                        box-shadow: inset 0 1px 0 #fff, 0 1px 0 rgba(0,0,0,.08);
                        vertical-align: top;
                    }

                    .button.button-large {
                        height: 29px;
                        line-height: 28px;
                        padding: 0 12px;
                    }

                    .button:hover,
                    .button:focus {
                        background: #fafafa;
                        border-color: #999;
                        color: #222;
                        text-decoration: none;
                    }

                    .button:focus  {
                        -webkit-box-shadow: 1px 1px 1px rgba(0,0,0,.2);
                        box-shadow: 1px 1px 1px rgba(0,0,0,.2);
                    }

                    .button:active {
                        background: #eee;
                        border-color: #999;
                        color: #333;
                        -webkit-box-shadow: inset 0 2px 5px -3px rgba( 0, 0, 0, 0.5 );
                        box-shadow: inset 0 2px 5px -3px rgba( 0, 0, 0, 0.5 );
                    }
                    .text-left {
                        text-align: left;
                    }
                    .text-center {
                        text-align: center;
                    }
                </style>
            </head>
            <body>
                <div class="error-title">' . $title . '</div>
                <div class="error-message">' . $message . '</div>
            </body>
            </html>';
  exit;
}



/* ------------------------------- */
/* Email */
/* ------------------------------- */

/**
 * _email
 * 
 * @param string $email
 * @param string $subject
 * @param string $body_html
 * @param string $body_plain
 * @param boolean $is_html
 * @param boolean $only_smtp
 * @return boolean
 */
function _email($email, $subject, $body_html, $body_plain, $is_html = true, $only_smtp = false)
{
  global $system;
  /* set header */
  $header  = "MIME-Version: 1.0\r\n";
  $header .= "Mailer: " . __($system['system_title']) . "\r\n";
  if ($system['system_email']) {
    $header = "From: " . $system['system_email'] . "\r\n";
    $header .= "Reply-To: " . $system['system_email'] . "\r\n";
  }
  if ($is_html) {
    $header .= "Content-Type: text/html; charset=\"utf-8\"\r\n";
  } else {
    $header .= "Content-Type: text/plain; charset=\"utf-8\"\r\n";
  }
  /* send email */
  if ($system['email_smtp_enabled']) {
    /* SMTP */
    $mail = new PHPMailer\PHPMailer\PHPMailer;
    $mail->CharSet = "UTF-8";
    $mail->isSMTP();
    $mail->Host = $system['email_smtp_server'];
    $mail->SMTPAuth = ($system['email_smtp_authentication']) ? true : false;
    $mail->Username = $system['email_smtp_username'];
    $mail->Password = html_entity_decode($system['email_smtp_password']);
    $mail->SMTPSecure = ($system['email_smtp_ssl']) ? 'ssl' : 'tls';
    $mail->Port = $system['email_smtp_port'];
    $setfrom = (is_empty($system['email_smtp_setfrom'])) ? $system['email_smtp_username'] : $system['email_smtp_setfrom'];
    $mail->setFrom($setfrom, $system['system_title']);
    $mail->addAddress($email);
    $mail->Subject = $subject;
    if ($is_html) {
      $mail->isHTML(true);
      $mail->Body = $body_html;
      $mail->AltBody = $body_plain;
    } else {
      $mail->Body = $body_plain;
    }
    if (!$mail->send()) {
      if ($only_smtp) {
        return false;
      }
      /* send using mail() */
      if (!mail($email, $subject, $body_html, $header)) {
        return false;
      }
    }
  } else {
    if ($only_smtp) {
      return false;
    }
    /* send using mail() */
    if (!mail($email, $subject, $body_html, $header)) {
      return false;
    }
  }
  return true;
}


/**
 * email_smtp_test
 * 
 * @return void
 */
function email_smtp_test()
{
  global $system;
  /* prepare test email */
  $subject = __("Test SMTP Connection on") . " " . __($system['system_title']);
  $body = get_email_template("test_email", $subject);
  /* send email */
  if (!_email($system['system_email'], $subject, $body['html'], $body['plain'], true, true)) {
    throw new Exception(__("Test email could not be sent. Please check your settings"));
  }
}


/**
 * get_email_template
 * 
 * @param string $template_name
 * @param string $template_subject
 * @param array $template_variables
 * @return array
 */
function get_email_template($template_name, $template_subject, $template_variables = [])
{
  global $smarty;
  $smarty->assign("template_subject", $template_subject);
  if ($template_variables) {
    foreach ($template_variables as $key => $value) {
      $smarty->assign($key, $value);
    }
  }
  $body['html'] = $smarty->fetch("emails/" . $template_name . ".html");
  $body['plain'] = $smarty->fetch("emails/" . $template_name . ".txt");
  return $body;
}



/* ------------------------------- */
/* SMS */
/* ------------------------------- */

/**
 * sms_send
 * 
 * @param string $phone
 * @param string $message
 * @return boolean
 */
function sms_send($phone, $message)
{
  global $system;
  switch ($system['sms_provider']) {
    case 'twilio':
      $client = new Twilio\Rest\Client($system['twilio_sid'], $system['twilio_token']);
      $message = $client->account->messages->create(
        $phone,
        [
          'from' => $system['twilio_phone'],
          'body' => $message
        ]
      );
      if (!$message->sid) {
        return false;
      }
      break;

    case 'bulksms':
      $username = $system['bulksms_username'];
      $password = $system['bulksms_password'];
      $messages = [
        [
          'to' => $phone,
          'body' => $message
        ]
      ];
      $headers = [
        'Content-Type:application/json',
        'Authorization:Basic ' . base64_encode("$username:$password")
      ];
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
      curl_setopt($ch, CURLOPT_URL, "https://api.bulksms.com/v1/messages?auto-unicode=true&longMessageMaxParts=30");
      curl_setopt($ch, CURLOPT_POST, 1);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($messages));
      curl_setopt($ch, CURLOPT_TIMEOUT, 20);
      curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
      $response = curl_exec($ch);
      $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
      if (curl_errno($ch)) {
        return false;
      }
      curl_close($ch);
      if ($httpCode != 201) {
        return false;
      }
      break;

    case 'infobip':
      $sms = [
        "from" => $system['system_title'],
        "to" => $phone,
        "text" => $message
      ];
      $header = [
        "Content-Type:application/json",
        "Accept:application/json"
      ];
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, "https://api.infobip.com/sms/1/text/single");
      curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
      curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
      curl_setopt($ch, CURLOPT_USERPWD, $system['infobip_username'] . ":" . $system['infobip_password']);
      curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 2);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
      curl_setopt($ch, CURLOPT_MAXREDIRS, 2);
      curl_setopt($ch, CURLOPT_POST, 1);
      curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($sms));
      curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
      $response = curl_exec($ch);
      $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
      if (curl_errno($ch)) {
        return false;
      }
      curl_close($ch);
      if (!($httpCode >= 200 && $httpCode < 300)) {
        return false;
      }
      break;

    case 'msg91':
      $sms = [
        'authkey' => $system['msg91_authkey'],
        'mobiles' => $phone,
        'message' => $message,
        'sender' => uniqid(),
        'route' => "4"
      ];
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, "http://api.msg91.com/api/sendhttp.php");
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_POST, 1);
      curl_setopt($ch, CURLOPT_POSTFIELDS, $sms);
      curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
      curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
      $response = curl_exec($ch);
      if (curl_errno($ch)) {
        return false;
      }
      curl_close($ch);
      break;
  }
  return true;
}


/**
 * sms_test
 * 
 * @return void
 */
function sms_test()
{
  global $system;
  if (is_empty($system['system_phone'])) {
    throw new Exception(__("You need to enter Test Phone Number"));
  }
  switch ($system['sms_provider']) {
    case 'twilio':
      $client = new Twilio\Rest\Client($system['twilio_sid'], $system['twilio_token']);
      $message = $client->account->messages->create(
        $system['system_phone'],
        [
          'from' => $system['twilio_phone'],
          'body' => __("Test SMS from") . " " . __($system['system_title'])
        ]
      );
      if (!$message->sid) {
        throw new Exception(__("Test SMS could not be sent. Please check your settings"));
      }
      break;

    case 'bulksms':
      $username = $system['bulksms_username'];
      $password = $system['bulksms_password'];
      $messages = [
        [
          'to' => $system['system_phone'],
          'body' => __("Test SMS from") . " " . __($system['system_title'])
        ]
      ];
      $headers = [
        'Content-Type:application/json',
        'Authorization:Basic ' . base64_encode("$username:$password")
      ];
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
      curl_setopt($ch, CURLOPT_URL, "https://api.bulksms.com/v1/messages?auto-unicode=true&longMessageMaxParts=30");
      curl_setopt($ch, CURLOPT_POST, 1);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($messages));
      curl_setopt($ch, CURLOPT_TIMEOUT, 20);
      curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
      $response = curl_exec($ch);
      $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
      if (curl_errno($ch)) {
        throw new Exception(__("Test SMS could not be sent. Please check your settings"));
      }
      curl_close($ch);
      if ($httpCode != 201) {
        throw new Exception(__("Test SMS could not be sent. Please check your settings"));
      }
      break;

    case 'infobip':
      $sms = [
        "from" => $system['system_title'],
        "to" => $system['system_phone'],
        "text" => __("Test SMS from") . " " . __($system['system_title'])
      ];
      $header = [
        "Content-Type:application/json",
        "Accept:application/json"
      ];
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, "https://api.infobip.com/sms/1/text/single");
      curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
      curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
      curl_setopt($ch, CURLOPT_USERPWD, $system['infobip_username'] . ":" . $system['infobip_password']);
      curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 2);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
      curl_setopt($ch, CURLOPT_MAXREDIRS, 2);
      curl_setopt($ch, CURLOPT_POST, 1);
      curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($sms));
      curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
      $response = curl_exec($ch);
      $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
      if (curl_errno($ch)) {
        throw new Exception(__("Test SMS could not be sent. Please check your settings"));
      }
      curl_close($ch);
      if (!($httpCode >= 200 && $httpCode < 300)) {
        throw new Exception(__("Test SMS could not be sent. Please check your settings"));
      }
      break;

    case 'msg91':
      $message = urlencode(__("Test SMS from") . " " . __($system['system_title']));
      $sms = [
        'authkey' => $system['msg91_authkey'],
        'mobiles' => $system['system_phone'],
        'message' => $message,
        'sender' => uniqid(),
        'route' => "4"
      ];
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, "http://api.msg91.com/api/sendhttp.php");
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_POST, 1);
      curl_setopt($ch, CURLOPT_POSTFIELDS, $sms);
      curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
      curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
      $response = curl_exec($ch);
      if (curl_errno($ch)) {
        throw new Exception(__("Test SMS could not be sent. Please check your settings"));
      }
      curl_close($ch);
      break;
  }
}



/* ------------------------------- */
/* OneSignal Notifications */
/* ------------------------------- */

/**
 * onesignal_notification
 * 
 * @param string $send_to
 * @param string $notification
 * @return void
 */
function onesignal_notification($send_to, $notification)
{
  global $system;
  $fields = [
    'app_id' => $system['onesignal_app_id'],
    'include_player_ids' => [$send_to],
    'url' => $notification['url'],
    'contents' => [
      'en' => $notification['full_message']
    ],
    'headings' => [
      'en' => $system['system_title']
    ],
  ];
  $fields = json_encode($fields);
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, "https://onesignal.com/api/v1/notifications");
  curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json; charset=utf-8'));
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
  curl_setopt($ch, CURLOPT_HEADER, FALSE);
  curl_setopt($ch, CURLOPT_POST, TRUE);
  curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
  $response = curl_exec($ch);
  curl_close($ch);
}



/* ------------------------------- */
/* Google Vision */
/* ------------------------------- */

/**
 * google_vision_test
 * 
 * @return void
 */
function google_vision_test()
{
  global $system;
  $image_source = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/og-image.jpg';
  $content = '{
        "requests":[
            {
                "image":{
                    "content": "' . base64_encode(file_get_contents($image_source)) . '",
                },
                "features":[
                    {
                        "type":"SAFE_SEARCH_DETECTION",
                        "maxResults":1
                    },
                    {
                        "type":"WEB_DETECTION",
                        "maxResults":2
                    }
                ]
            }
        ]
    }';
  try {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'https://vision.googleapis.com/v1/images:annotate?key=' . $system['adult_images_api_key']);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'Content-Length: ' . strlen($content)));
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
    curl_setopt($ch, CURLOPT_POSTFIELDS, $content);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response  = curl_exec($ch);
    curl_close($ch);
    $responseJson = json_decode($response);
    if ($responseJson->error) {
      throw new Exception($responseJson->error->message);
    }
    if ($responseJson->responses[0]->error) {
      throw new Exception($responseJson->responses[0]->error->message);
    }
    if (!$responseJson->responses[0]->safeSearchAnnotation) {
      throw new Exception(__("Connection Failed, Please check your settings"));
    }
  } catch (Exception $e) {
    if (DEBUGGING) {
      throw new Exception($e->getMessage());
    } else {
      throw new Exception(__("Connection Failed, Please check your settings"));
    }
  }
}


/**
 * google_vision_check
 * 
 * @param string $image_source
 * @return boolean
 */
function google_vision_check($image_source)
{
  global $system;
  $content = '{
        "requests":[
            {
                "image":{
                    "content": "' . base64_encode(file_get_contents($image_source)) . '",
                },
                "features":[
                    {
                        "type":"SAFE_SEARCH_DETECTION",
                        "maxResults":1
                    },
                    {
                        "type":"WEB_DETECTION",
                        "maxResults":2
                    }
                ]
            }
        ]
    }';
  try {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'https://vision.googleapis.com/v1/images:annotate?key=' . $system['adult_images_api_key']);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'Content-Length: ' . strlen($content)));
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
    curl_setopt($ch, CURLOPT_POSTFIELDS, $content);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response  = curl_exec($ch);
    curl_close($ch);
    $responseJson = json_decode($response);
    if ($responseJson->error) {
      return false;
    }
    if ($responseJson->responseJsons[0]->error) {
      return false;
    }
    if ($responseJson->responseJsons[0]->safeSearchAnnotation->adult == 'LIKELY' || $responseJson->responseJsons[0]->safeSearchAnnotation->adult == 'VERY_LIKELY') {
      return true;
    } else {
      return false;
    }
  } catch (Exception $e) {
    return false;
  }
}


/* ------------------------------- */
/* Cloud Storage */
/* ------------------------------- */

/**
 * aws_s3_test
 * 
 * @param string $s3_bucket
 * @param string $s3_region
 * @param string $s3_key
 * @param string $s3_secret
 *
 * @return void
 */
function aws_s3_test($s3_bucket, $s3_region, $s3_key, $s3_secret)
{
  try {
    $s3Client = Aws\S3\S3Client::factory(array(
      'version'    => 'latest',
      'region'      => $s3_region,
      'credentials' => array(
        'key'    => $s3_key,
        'secret' => $s3_secret,
      )
    ));
    $buckets = $s3Client->listBuckets();
    if (empty($buckets)) {
      throw new Exception(__("There is no buckets in your account"));
    }
    if (!$s3Client->doesBucketExist($s3_bucket)) {
      throw new Exception(__("There is no bucket with this name in your account"));
    }
  } catch (Exception $e) {
    if (DEBUGGING) {
      throw new Exception($e->getMessage());
    } else {
      throw new Exception(__("Connection Failed, Please check your settings"));
    }
  }
}


/**
 * aws_s3_upload
 * 
 * @param string $file_source
 * @param string $file_name
 * @param string $content_type
 * @return void
 */
function aws_s3_upload($file_source, $file_name, $content_type = "")
{
  global $system;
  $s3Client = Aws\S3\S3Client::factory(array(
    'version'     => 'latest',
    'region'      => $system['s3_region'],
    'credentials' => array(
      'key'     => $system['s3_key'],
      'secret'  => $system['s3_secret'],
    )
  ));
  $Key = 'uploads/' . $file_name;
  $s3Client->putObject([
    'Bucket' => $system['s3_bucket'],
    'Key'    => $Key,
    'Body'   => fopen($file_source, 'r+'),
    'ContentDisposition' => 'inline',
    'ContentType' => $content_type,
    'ACL'    => 'public-read',
  ]);
  /* remove local file */
  gc_collect_cycles();
  if ($s3Client->doesObjectExist($system['s3_bucket'], $Key)) {
    unlink($file_source);
  }
}


/**
 * digitalocean_space_test
 * 
 * @return void
 */
function digitalocean_space_test()
{
  global $system;
  try {
    $spaces = Spaces($system['digitalocean_key'], $system['digitalocean_secret']);
    $space = $spaces->space($system['digitalocean_space_name'], $system['digitalocean_space_region']);
    $space->setCORS([["headers" => ["Authorization"], "origins" => ["*"], "methods" => ["GET"]]]);
  } catch (Exception $e) {
    if (DEBUGGING) {
      throw new Exception($e->getMessage());
    } else {
      throw new Exception(__("Connection Failed, Please check your settings"));
    }
  }
}


/**
 * digitalocean_space_upload
 * 
 * @param string $file_source
 * @param string $file_name
 * @return void
 */
function digitalocean_space_upload($file_source, $file_name)
{
  global $system;
  $space = Spaces($system['digitalocean_key'], $system['digitalocean_secret'])->space($system['digitalocean_space_name'], $system['digitalocean_space_region']);
  $Key = 'uploads/' . $file_name;
  $space->uploadFile($file_source, $Key, "public");
  /* remove local file */
  if ($space->fileExists($Key)) {
    unlink($file_source);
  }
}


/**
 * wasabi_test
 * 
 * @param string $wasabi_bucket
 * @param string $wasabi_region
 * @param string $wasabi_key
 * @param string $wasabi_secret
 *
 * @return void
 */
function wasabi_test($wasabi_bucket, $wasabi_region, $wasabi_key, $wasabi_secret)
{
  try {
    $s3Client = Aws\S3\S3Client::factory(array(
      'version'     => 'latest',
      'endpoint'    => 'https://s3.' . $wasabi_region . '.wasabisys.com',
      'region'      => $wasabi_region,
      'credentials' => array(
        'key'     => $wasabi_key,
        'secret'  => $wasabi_secret,
      )
    ));
    $buckets = $s3Client->listBuckets();
    if (empty($buckets)) {
      throw new Exception(__("There is no buckets in your account"));
    }
    if (!$s3Client->doesBucketExist($wasabi_bucket)) {
      throw new Exception(__("There is no bucket with this name in your account"));
    }
  } catch (Exception $e) {
    if (DEBUGGING) {
      throw new Exception($e->getMessage());
    } else {
      throw new Exception(__("Connection Failed, Please check your settings"));
    }
  }
}


/**
 * wasabi_upload
 * 
 * @param string $file_source
 * @param string $file_name
 * @param string $content_type
 * @return void
 */
function wasabi_upload($file_source, $file_name, $content_type = "")
{
  global $system;
  $s3Client = Aws\S3\S3Client::factory(array(
    'version'     => 'latest',
    'endpoint'    => 'https://s3.' . $system['wasabi_region'] . '.wasabisys.com',
    'region'      => $system['wasabi_region'],
    'credentials' => array(
      'key'     => $system['wasabi_key'],
      'secret'  => $system['wasabi_secret'],
    )
  ));
  $Key = 'uploads/' . $file_name;
  $s3Client->putObject([
    'Bucket' => $system['wasabi_bucket'],
    'Key'    => $Key,
    'Body'   => fopen($file_source, 'r+'),
    'ContentDisposition' => 'inline',
    'ContentType' => $content_type,
    'ACL'    => 'public-read',
  ]);
  /* remove local file */
  gc_collect_cycles();
  if ($s3Client->doesObjectExist($system['wasabi_bucket'], $Key)) {
    unlink($file_source);
  }
}


/**
 * google_cloud_test
 * 
 * @param string $google_cloud_bucket
 * @param string $google_cloud_file
 *
 * @return void
 */
function google_cloud_test($google_cloud_bucket, $google_cloud_file)
{
  try {
    $storage = new Google\Cloud\Storage\StorageClient([
      'keyFile' => json_decode(html_entity_decode($google_cloud_file, ENT_QUOTES), true),
    ]);
    $bucket = $storage->bucket($google_cloud_bucket);
    if (!$bucket->exists()) {
      throw new Exception(__("There is no buckets in your account"));
    }
  } catch (Exception $e) {
    if (DEBUGGING) {
      throw new Exception($e->getMessage());
    } else {
      throw new Exception(__("Connection Failed, Please check your settings"));
    }
  }
}


/**
 * google_cloud_upload
 * 
 * @param string $file_source
 * @param string $file_name
 * @param string $content_type
 * @return void
 */
function google_cloud_upload($file_source, $file_name, $content_type = "")
{
  global $system;
  $storage = new Google\Cloud\Storage\StorageClient([
    'keyFile' => json_decode(html_entity_decode($system['google_cloud_file'], ENT_QUOTES), true),
  ]);
  $bucket = $storage->bucket($system['google_cloud_bucket']);
  $fileContent = file_get_contents($file_source);
  $Key = 'uploads/' . $file_name;
  $storageObject = $bucket->upload($fileContent, ['name' => $Key]);
  /* remove local file */
  gc_collect_cycles();
  if (!empty($storageObject)) {
    unlink($file_source);
  }
}


/**
 * ftp_test
 * 
 * @return void
 */
function ftp_test()
{
  global $system;
  try {
    $ftp = new \FtpClient\FtpClient();
    $ftp->connect($system['ftp_hostname'], false, $system['ftp_port']);
    $ftp->login($system['ftp_username'], $system['ftp_password']);
  } catch (Exception $e) {
    if (DEBUGGING) {
      throw new Exception($e->getMessage());
    } else {
      throw new Exception(__("Connection Failed, Please check your settings"));
    }
  }
}


/**
 * ftp_upload
 * 
 * @param string $file_source
 * @param string $file_name
 * @return void
 */
function ftp_upload($file_source, $file_name)
{
  global $system;
  $ftp = new \FtpClient\FtpClient();
  $ftp->connect($system['ftp_hostname'], false, $system['ftp_port']);
  $ftp->login($system['ftp_username'], $system['ftp_password']);
  if (!empty($system['ftp_path']) && $system['ftp_path'] != "./") {
    $ftp->chdir($system['ftp_path']);
  }
  $file_path = substr($file_name, 0, strrpos($file_name, '/'));
  $ftp_path_info = explode('/', $file_path);
  $ftp_path = '';
  if (!$ftp->isDir($file_path)) {
    foreach ($ftp_path_info as $key => $value) {
      if (!empty($ftp_path)) {
        $ftp_path .= '/' . $value . '/';
      } else {
        $ftp_path .= $value . '/';
      }
      if (!$ftp->isDir($ftp_path)) {
        $mkdir = $ftp->mkdir($ftp_path);
      }
    }
  }
  $ftp->chdir($file_path);
  $ftp->pasv(true);
  if ($ftp->putFromPath($file_source, $file_name)) {
    unlink($file_source);
  }
  $ftp->close();
}


/**
 * delete_uploads_file
 * 
 * @param string $file_name
 * @return void
 */
function delete_uploads_file($file_name)
{
  global $system;
  if (!$file_name) {
    return;
  }
  if ($system['s3_enabled']) {
    /* Amazon S3 */
    $s3Client = Aws\S3\S3Client::factory(array(
      'version'    => 'latest',
      'region'      => $system['s3_region'],
      'credentials' => array(
        'key'    => $system['s3_key'],
        'secret' => $system['s3_secret'],
      )
    ));
    $Key = 'uploads/' . $file_name;
    if ($s3Client->doesObjectExist($system['s3_bucket'], $Key)) {
      $s3Client->deleteObject([
        'Bucket' => $system['s3_bucket'],
        'Key'    => $Key,
      ]);
    }
  } elseif ($system['digitalocean_enabled']) {
    /* DigitalOcean */
    $space = Spaces($system['digitalocean_key'], $system['digitalocean_secret'])->space($system['digitalocean_space_name'], $system['digitalocean_space_region']);
    $Key = 'uploads/' . $file_name;
    if ($space->fileExists($Key)) {
      $space->deleteFile($Key);
    }
  } elseif ($system['wasabi_enabled']) {
    /* Wasabi */
    $s3Client = Aws\S3\S3Client::factory(array(
      'version'    => 'latest',
      'region'      => $system['wasabi_bucket'],
      'credentials' => array(
        'key'    => $system['wasabi_key'],
        'secret' => $system['wasabi_secret'],
      )
    ));
    $Key = 'uploads/' . $file_name;
    if ($s3Client->doesObjectExist($system['wasabi_bucket'], $Key)) {
      $s3Client->deleteObject([
        'Bucket' => $system['wasabi_bucket'],
        'Key'    => $Key,
      ]);
    }
  } elseif ($system['google_cloud_enabled']) {
    /* Google Cloud */
    $storage = new Google\Cloud\Storage\StorageClient([
      'keyFile' => json_decode(html_entity_decode($system['google_cloud_file'], ENT_QUOTES), true),
    ]);
    $bucket = $storage->bucket($system['google_cloud_bucket']);
    $Key = 'uploads/' . $file_name;
    $object = $bucket->object($Key);
    if ($object->exists()) {
      $object->delete();
    }
  } elseif ($system['ftp_enabled']) {
    /* FTP */
    $ftp = new \FtpClient\FtpClient();
    $ftp->connect($system['ftp_hostname'], false, $system['ftp_port']);
    $ftp->login($system['ftp_username'], $system['ftp_password']);
    if (!empty($system['ftp_path']) && $system['ftp_path'] != "./") {
      $ftp->chdir($system['ftp_path']);
    }
    $file_path = substr($file_name, 0, strrpos($file_name, '/'));
    $file_name = substr($file_name, strrpos($file_name, '/') + 1);
    if (!$ftp->isDir($file_path)) {
      return;
    }
    $ftp->chdir($file_path);
    $ftp->pasv(true);
    $ftp->remove($file_name);
    $ftp->close();
  } else {
    /* local server */
    $realpath = realpath(ABSPATH . $system['uploads_directory'] . '/' . $file_name);
    if (is_file($realpath) && file_exists($realpath)) {
      unlink($realpath);
    }
  }
}



/* ------------------------------- */
/* PayPal */
/* ------------------------------- */

/**
 * paypal
 * 
 * @param string $handle
 * @param string $price
 * @param integer $id
 * @return string
 */
function paypal($handle, $price, $id = null)
{
  global $system;
  /* prepare */
  switch ($handle) {
    case 'packages':
      $product = __($system['system_title']) . " " . __('Pro Package');
      $description = __('Pay For') . " " . __($system['system_title']);
      $URL['success'] = $system['system_url'] . "/paypal.php?status=success&handle=packages&package_id=" . $id;
      $URL['cancel'] = $system['system_url'] . "/paypal.php?status=cancel";
      break;

    case 'wallet':
      $product = __($system['system_title']) . " " . __('Wallet');
      $description = __('Pay For') . " " . __($system['system_title']);
      $URL['success'] = $system['system_url'] . "/paypal.php?status=success&handle=wallet";
      $URL['cancel'] = $system['system_url'] . "/paypal.php?status=cancel";
      $_SESSION['wallet_replenish_amount'] = $price;
      break;

    case 'donate':
      $product = __($system['system_title']) . " " . __('Funding Donation');
      $description = __('Pay For') . " " . __($system['system_title']);
      $URL['success'] = $system['system_url'] . "/paypal.php?status=success&handle=donate&post_id=" . $id;
      $URL['cancel'] = $system['system_url'] . "/paypal.php?status=cancel";
      $_SESSION['donation_amount'] = $price;
      break;

    default:
      _error(400);
      break;
  }
  /* Paypal */
  $paypal = new \PayPal\Rest\ApiContext(
    new \PayPal\Auth\OAuthTokenCredential(
      $system['paypal_id'],
      $system['paypal_secret']
    )
  );
  $paypal->setConfig(
    array(
      'mode' => $system['paypal_mode']
    )
  );
  $payer = new PayPal\Api\Payer();
  $payer->setPaymentMethod('paypal');
  $item = new PayPal\Api\Item();
  $item->setName($product)->setQuantity(1)->setPrice($price)->setCurrency($system['system_currency']);
  $itemList = new PayPal\Api\ItemList();
  $itemList->setItems(array(
    $item
  ));
  $details = new PayPal\Api\Details();
  $details->setSubtotal($price);
  $amount = new PayPal\Api\Amount();
  $amount->setCurrency($system['system_currency'])->setTotal($price)->setDetails($details);
  $transaction = new PayPal\Api\Transaction();
  $transaction->setAmount($amount)->setItemList($itemList)->setDescription($description)->setInvoiceNumber(uniqid());
  $redirectUrls = new PayPal\Api\RedirectUrls();
  $redirectUrls->setReturnUrl($URL['success'])->setCancelUrl($URL['cancel']);
  $payment = new PayPal\Api\Payment();
  $payment->setIntent('sale')->setPayer($payer)->setRedirectUrls($redirectUrls)->setTransactions(array(
    $transaction
  ));
  $payment->create($paypal);
  return $payment->getApprovalLink();
}


/**
 * paypal_check
 * 
 * @param string $payment_id
 * @param string $payer_id
 * @return boolean
 */
function paypal_check($payment_id, $payer_id)
{
  global $system;
  $paypal = new \PayPal\Rest\ApiContext(
    new \PayPal\Auth\OAuthTokenCredential(
      $system['paypal_id'],
      $system['paypal_secret']
    )
  );
  $paypal->setConfig(
    array(
      'mode' => $system['paypal_mode']
    )
  );
  $payment = PayPal\Api\Payment::get($payment_id, $paypal);
  $execute = new PayPal\Api\PaymentExecution();
  $execute->setPayerId($payer_id);
  $result = $payment->execute($execute, $paypal);
  return true;
}



/* ------------------------------- */
/* Paystack */
/* ------------------------------- */

/**
 * paystack
 * 
 * @param string $handle
 * @param string $price
 * @param integer $id
 * @return string
 */
function paystack($handle, $price, $id = null)
{
  global $system, $user;
  /* prepare */
  switch ($handle) {
    case 'packages':
      $callback = $system['system_url'] . "/paystack.php?status=success&handle=packages&package_id=" . $id;
      break;

    case 'wallet':
      $callback = $system['system_url'] . "/paystack.php?status=success&handle=wallet";
      $_SESSION['wallet_replenish_amount'] = $price;
      break;

    case 'donate':
      $callback = $system['system_url'] . "/paystack.php?status=success&handle=donate&post_id=" . $id;
      $_SESSION['donation_amount'] = $price;
      break;

    default:
      _error(400);
      break;
  }
  /* Paystack */
  $data = [
    'email' => $user->_data['user_email'],
    'amount' => $price * 100,
    'callback_url' => $callback
  ];
  $headers = [
    'Authorization: Bearer ' . $system['paystack_secret'],
    'Content-Type: application/json',
  ];
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, "https://api.paystack.co/transaction/initialize");
  curl_setopt($ch, CURLOPT_POST, 1);
  curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
  curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  $response = curl_exec($ch);
  $responseJson = json_decode($response, true);
  if (!$responseJson['status']) {
    throw new Exception($responseJson['message']);
  }
  return $responseJson['data']['authorization_url'];
}


/**
 * paystack_check
 * 
 * @param string $reference
 * @return boolean
 */
function paystack_check($reference)
{
  global $system;
  $headers = [
    'Authorization: Bearer ' . $system['paystack_secret']
  ];
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, "https://api.paystack.co/transaction/verify/" . $reference);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
  $response = curl_exec($ch);
  $responseJson = json_decode($response, true);
  if ($responseJson['data']['status'] == 'success') {
    return true;
  }
  return false;
}



/* ------------------------------- */
/* Razorpay */
/* ------------------------------- */

/**
 * razorpay_check
 * 
 * @param string $payment_id
 * @param integer $amount
 * @return boolean
 */

function razorpay_check($payment_id, $amount)
{
  global $system;
  $url = 'https://api.razorpay.com/v1/payments/' . $payment_id . '/capture';
  $params = http_build_query(['amount' => $amount * 100, 'currency' => $system['currency']]);
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, $url);
  curl_setopt($ch, CURLOPT_USERPWD, $system['razorpay_key_id'] . ':' . $system['razorpay_key_secret']);
  curl_setopt($ch, CURLOPT_TIMEOUT, 60);
  curl_setopt($ch, CURLOPT_POST, 1);
  curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
  $response = curl_exec($ch);
  $responseJson = json_decode($response, true);
  if ($responseJson['error_code']) {
    return false;
  }
  return true;
}



/* ------------------------------- */
/* Cashfree */
/* ------------------------------- */

/**
 * cashfree
 * 
 * @param string $handle
 * @param string $price
 * @param integer $id
 * @param string $billing_name
 * @param string $billing_email
 * @param string $billing_phone
 * @return string
 */
function cashfree($handle, $price, $id = null, $billing_name, $billing_email, $billing_phone)
{
  global $system;
  /* prepare */
  $return_url = $system['system_url'] . "/cashfree.php?orderId={order_id}&token={order_token}";
  switch ($handle) {
    case 'packages':
      $return_url .= "&handle=packages&package_id=" . $id;
      break;

    case 'wallet':
      $return_url .= "&handle=wallet";
      $_SESSION['wallet_replenish_amount'] = $price;
      break;

    case 'donate':
      $return_url .= "&handle=donate&post_id=" . $id;
      $_SESSION['donation_amount'] = $price;
      break;

    default:
      _error(400);
      break;
  }
  $headers = array(
    "content-type: application/json",
    "x-client-id: " . $system['cashfree_client_id'],
    "x-client-secret: " . $system['cashfree_client_secret'],
    "x-api-version: " . "2021-05-21",
  );
  $data = array(
    "order_amount" => $price,
    "order_currency" => $system['system_currency'],
    "customer_details" => array(
      "customer_id" => uniqid(),
      "customer_email" => $billing_email,
      "customer_phone" => $billing_phone
    ),
    "order_meta" => array(
      "return_url" => $return_url,
      "notify_url" => "",
    )
  );
  $apiBase = ($system['cashfree_mode'] == 'sandbox') ? 'https://sandbox.cashfree.com/pg/' : 'https://api.cashfree.com/pg';
  $apiURL = $apiBase . "/orders";
  /* Cashfree */
  $ch = curl_init($apiURL);
  curl_setopt($ch, CURLOPT_VERBOSE, 1);
  curl_setopt($ch, CURLOPT_URL, $apiURL);
  curl_setopt($ch, CURLOPT_POST, true);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
  curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
  $response = curl_exec($ch);
  if (curl_errno($ch)) {
    throw new Exception("Error Processing Request");
  }
  $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  $responseJson = json_decode($response, true);
  curl_close($ch);
  if ($httpCode != 200) {
    throw new Exception($responseJson['message']);
  }
  return $responseJson["payment_link"];
}


/**
 * cashfree_check
 * 
 * @param string $orderId
 * @return boolean
 */
function cashfree_check($orderId)
{
  global $system;
  /* prepare */
  $headers = array(
    "content-type: application/json",
    "x-client-id: " . $system['cashfree_client_id'],
    "x-client-secret: " . $system['cashfree_client_secret'],
    "x-api-version: " . "2021-05-21",
  );
  $apiBase = ($system['cashfree_mode'] == 'sandbox') ? 'https://sandbox.cashfree.com/pg/' : 'https://api.cashfree.com/pg';
  $apiURL = $apiBase . "/orders/" . $orderId;
  /* Cashfree */
  $ch = curl_init($apiURL);
  curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  $response = curl_exec($ch);
  if ($response === false) {
    throw new Exception("Unable to get to cashfree");
  }
  $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  $responseJson = json_decode($response, true);
  curl_close($ch);
  if ($httpCode == 200) {
    return true;
  }
  return false;
}



/* ------------------------------- */
/* Coinbase */
/* ------------------------------- */

/**
 * coinbase
 * 
 * @param string $handle
 * @param string $price
 * @param integer $id
 * @return array
 */
function coinbase($handle, $price, $id = null)
{
  global $system;
  /* prepare */
  $coinbase_hash = get_hash_token();
  switch ($handle) {
    case 'packages':
      $product = __($system['system_title']) . " " . __('Pro Package');
      $description = __('Pay For') . " " . __($system['system_title']);
      $URL['success'] = $system['system_url'] . "/coinbase.php?status=success&handle=packages&package_id=" . $id . '&coinbase_hash=' . $coinbase_hash;
      $URL['cancel'] = $system['system_url'] . "/coinbase.php?status=cancel";
      break;

    case 'wallet':
      $product = __($system['system_title']) . " " . __('Wallet');
      $description = __('Pay For') . " " . __($system['system_title']);
      $URL['success'] = $system['system_url'] . "/coinbase.php?status=success&handle=wallet" . '&coinbase_hash=' . $coinbase_hash;
      $URL['cancel'] = $system['system_url'] . "/coinbase.php?status=cancel";
      $_SESSION['wallet_replenish_amount'] = $price;
      break;

    case 'donate':
      $product = __($system['system_title']) . " " . __('Funding Donation');
      $description = __('Pay For') . " " . __($system['system_title']);
      $URL['success'] = $system['system_url'] . "/coinbase.php?status=success&handle=donate&post_id=" . $id . '&coinbase_hash=' . $coinbase_hash;
      $URL['cancel'] = $system['system_url'] . "/coinbase.php?status=cancel";
      $_SESSION['donation_amount'] = $price;
      break;

    default:
      _error(400);
      break;
  }
  $headers = [
    "content-type: application/json",
    "X-Cc-Api-Key: " . $system['coinbase_api_key'],
    "X-Cc-Version: " . "2018-03-22",
  ];
  $data =  [
    'name' =>  $product,
    'description' => $description,
    'pricing_type' => 'fixed_price',
    'local_price' => [
      'amount' => $price,
      'currency' => $system['system_currency']
    ],
    'metadata' => [
      'coinbase_hash' => $coinbase_hash
    ],
    "redirect_url" => $URL['success'],
    'cancel_url' => $URL['cancel']
  ];
  /* Coinbase */
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, 'https://api.commerce.coinbase.com/charges');
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_POST, 1);
  curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
  curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
  $response = curl_exec($ch);
  if (curl_errno($ch)) {
    throw new Exception("Error Processing Request");
  }
  $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  $responseJson = json_decode($response, true);
  curl_close($ch);
  return [
    "coinbase_hash" => $coinbase_hash,
    "coinbase_code" => $responseJson['data']['code'],
    "hosted_url" => $responseJson["data"]["hosted_url"]
  ];
}


/**
 * coinbase_check
 * 
 * @param string $coinbase_code
 * @return boolean
 */
function coinbase_check($coinbase_code)
{
  global $system;
  /* prepare */
  $headers = [
    "content-type: application/json",
    "X-Cc-Api-Key: " . $system['coinbase_api_key'],
    "X-Cc-Version: " . "2018-03-22",
  ];
  /* Coinbase */
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, 'https://api.commerce.coinbase.com/charges/' . $coinbase_code);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
  $response = curl_exec($ch);
  $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  $responseJson = json_decode($response, true);
  curl_close($ch);
  if (!empty($responseJson) && $responseJson['data']['payments'][0]['status'] == 'CONFIRMED') {
    return true;
  }
  return false;
}



/* ------------------------------- */
/* SecurionPay */
/* ------------------------------- */

/**
 * securionpay
 * 
 * @param string $price
 * @return string
 */
function securionpay($price)
{
  global $system;
  $securionPay = new SecurionPay\SecurionPayGateway($system['securionpay_api_secret']);
  $checkoutCharge = new SecurionPay\Request\CheckoutRequestCharge();
  $checkoutCharge->amount($price * 100)->currency($system['system_currency']);
  $checkoutRequest = new SecurionPay\Request\CheckoutRequest();
  $checkoutRequest->charge($checkoutCharge);
  $signedCheckoutRequest = $securionPay->signCheckoutRequest($checkoutRequest);
  return $signedCheckoutRequest;
}


/**
 * securionpay_check
 * 
 * @param string $charge_id
 * @return boolean
 */
function securionpay_check($charge_id)
{
  global $system;
  /* SecurionPay */
  $url = "https://api.securionpay.com/charges?limit=10";
  $ch = curl_init($url);
  curl_setopt($ch, CURLOPT_URL, $url);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
  curl_setopt($ch, CURLOPT_USERPWD, $system['securionpay_api_secret'] . ":password");
  $response = curl_exec($ch);
  $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  $responseJson = json_decode($response, true);
  curl_close($ch);
  if (!empty($responseJson) && $responseJson['list'][0]['id'] == $charge_id) {
    return true;
  }
  return false;
}



/* ------------------------------- */
/* User Access */
/* ------------------------------- */

/**
 * user_access
 * 
 * @param boolean $is_ajax
 * @param boolean $bypass_subscription
 * @return void
 */
function user_access($is_ajax = false, $bypass_subscription = false)
{
  global $user, $system;
  if ($is_ajax) {
    /* check user logged in */
    if (!$user->_logged_in) {
      modal('LOGIN');
    }
    /* check user activated */
    if ($system['activation_enabled'] && !$user->_data['user_activated']) {
      modal("MESSAGE", __("Not Activated"), __("Before you can interact with other users, you need to confirm your email address"));
    }
    /* check registration type */
    if ($system['registration_type'] == "paid" && $user->_data['user_group'] > '1' && !$user->_data['user_subscribed'] && !$bypass_subscription) {
      modal("MESSAGE", __("Subscription Needed"), __("Before you can interact with other users, you need to buy subscription package"));
    }
  } else {
    if (!$user->_logged_in) {
      user_login();
    } else {
      /* check registration type */
      if ($system['registration_type'] == "paid" && $user->_data['user_group'] > '1' && !$user->_data['user_subscribed']) {
        redirect('/packages');
      }
      /* check user activated */
      if ($system['activation_enabled'] && $system['activation_required'] && !$user->_data['user_activated']) {
        _error("activation");
      }
      /* check if getted started */
      if ($system['getting_started'] && !$user->_data['user_started']) {
        redirect('/started');
      }
    }
  }
}


/**
 * user_login
 * 
 * @return void
 */
function user_login()
{
  global $user, $smarty;
  $smarty->assign('genders', $user->get_genders());
  $smarty->assign('highlight', __("You must sign in to see this page"));
  page_header(__("Sign in"));
  page_footer('sign');
  exit;
}



/* ------------------------------- */
/* Modal */
/* ------------------------------- */

/**
 * modal
 * 
 * @return json
 */
function modal()
{
  $args = func_get_args();
  switch ($args[0]) {
    case 'LOGIN':
      return_json(array("callback" => "modal('#modal-login')"));
      break;
    case 'MESSAGE':
      return_json(array("callback" => "modal('#modal-message', {title: '" . $args[1] . "', message: '" . addslashes($args[2]) . "'})"));
      break;
    case 'ERROR':
      return_json(array("callback" => "modal('#modal-error', {title: '" . $args[1] . "', message: '" . addslashes($args[2]) . "'})"));
      break;
    case 'SUCCESS':
      return_json(array("callback" => "modal('#modal-success', {title: '" . $args[1] . "', message: '" . addslashes($args[2]) . "'})"));
      break;
    default:
      if (isset($args[1])) {
        return_json(array("callback" => "modal('" . $args[0] . "', " . $args[1] . ")"));
      } else {
        return_json(array("callback" => "modal('" . $args[0] . "')"));
      }
      break;
  }
}



/* ------------------------------- */
/* Popover */
/* ------------------------------- */

/**
 * popover
 * 
 * @param integer $uid
 * @param string $username
 * @param string $name
 * @return string
 */
function popover($uid, $username, $name)
{
  global $system;
  $popover = '<span class="js_user-popover" data-uid="' . $uid . '"><a href="' . $system['system_url'] . '/' . $username . '">' . $name . '</a></span>';
  return $popover;
}



/* ------------------------------- */
/* Page */
/* ------------------------------- */

/**
 * page_header
 * 
 * @param string $title
 * @param string $description
 * @return void
 */
function page_header($title, $description = '', $image = '')
{
  global $smarty, $system;
  $description = ($description != '') ? $description : $system['system_description'];
  if ($image == '') {
    if ($system['system_ogimage']) {
      $image = $system['system_uploads'] . '/' . $system['system_ogimage'];
    } else {
      $image = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/og-image.jpg';
    }
  }
  $smarty->assign('page_title', $title);
  $smarty->assign('page_description', $description);
  $smarty->assign('page_image', $image);
}


/**
 * page_footer
 * 
 * @param string $page
 * @return void
 */
function page_footer($page)
{
  global $smarty;
  $smarty->assign('page', $page);
  $smarty->display("$page.tpl");
}



/* ------------------------------- */
/* Post Feelings */
/* ------------------------------- */

/**
 * get_feelings
 * 
 * @return array
 */
function get_feelings()
{
  $feelings = array(
    array("icon" => "grinning-face-with-smiling-eyes",  "action" => "Feeling",      "text" => __("Feeling"),      "placeholder" => __("How are you feeling?")),
    array("icon" => "headphone",                        "action" => "Listening To", "text" => __("Listening To"), "placeholder" => __("What are you listening to?")),
    array("icon" => "glasses",                          "action" => "Watching",     "text" => __("Watching"),     "placeholder" => __("What are you watching?")),
    array("icon" => "video-game",                       "action" => "Playing",      "text" => __("Playing"),      "placeholder" => __("What are you playing?")),
    array("icon" => "shortcake",                        "action" => "Eating",       "text" => __("Eating"),       "placeholder" => __("What are you eating?")),
    array("icon" => "tropical-drink",                   "action" => "Drinking",     "text" => __("Drinking"),     "placeholder" => __("What are you drinking?")),
    array("icon" => "airplane",                         "action" => "Traveling To", "text" => __("Traveling To"), "placeholder" => __("Where are you going?")),
    array("icon" => "books",                            "action" => "Reading",      "text" => __("Reading"),      "placeholder" => __("What are you reading?")),
    array("icon" => "calendar",                         "action" => "Attending",    "text" => __("Attending"),    "placeholder" => __("What are you attending?")),
    array("icon" => "birthday-cake",                    "action" => "Celebrating",  "text" => __("Celebrating"),  "placeholder" => __("What are you celebrating?")),
    array("icon" => "magnifying-glass-tilted-left",     "action" => "Looking For",  "text" => __("Looking For"),  "placeholder" => __("What are you looking for?"))
  );
  return $feelings;
}


/**
 * get_feelings_types
 * 
 * @return array
 */
function get_feelings_types()
{
  $feelings_types = array(
    array("icon" => "grinning-face-with-smiling-eyes",  "action" => "Happy",      "text" => __("Happy")),
    array("icon" => "smiling-face-with-heart-eyes",     "action" => "Loved",      "text" => __("Loved")),
    array("icon" => "relieved-face",                    "action" => "Satisfied",  "text" => __("Satisfied")),
    array("icon" => "flexed-biceps",                    "action" => "Strong",     "text" => __("Strong")),
    array("icon" => "disappointed-face",                "action" => "Sad",        "text" => __("Sad")),
    array("icon" => "winking-face-with-tongue",         "action" => "Crazy",      "text" => __("Crazy")),
    array("icon" => "downcast-face-with-sweat",         "action" => "Tired",      "text" => __("Tired")),
    array("icon" => "sleeping-face",                    "action" => "Sleepy",     "text" => __("Sleepy")),
    array("icon" => "confused-face",                    "action" => "Confused",   "text" => __("Confused")),
    array("icon" => "worried-face",                     "action" => "Worried",    "text" => __("Worried")),
    array("icon" => "angry-face",                       "action" => "Angry",      "text" => __("Angry")),
    array("icon" => "pouting-face",                     "action" => "Annoyed",    "text" => __("Annoyed")),
    array("icon" => "face-with-open-mouth",             "action" => "Shocked",    "text" => __("Shocked")),
    array("icon" => "pensive-face",                     "action" => "Down",       "text" => __("Down")),
    array("icon" => "confounded-face",                  "action" => "Confounded", "text" => __("Confounded"))
  );
  return $feelings_types;
}


/**
 * get_feeling_icon
 * 
 * @param string $needle
 * @param array $array
 * @param string $key
 * @return string
 */
function get_feeling_icon($needle, $array, $key = "action")
{
  foreach ($array as $_key => $_val) {
    if ($_val[$key] === $needle) {
      return $array[$_key]['icon'];
    }
  }
  return false;
}



/* ------------------------------- */
/* Post Reactions */
/* ------------------------------- */

/**
 * get_reactions
 * 
 * @return array
 */
function get_reactions()
{
  $reactions = [
    ["reaction" => "like",   "color" => "blue",    "title" => __("like")],
    ["reaction" => "love",   "color" => "red",     "title" => __("love")],
    ["reaction" => "haha",   "color" => "yellow",  "title" => __("haha")],
    ["reaction" => "yay",    "color" => "yellow",  "title" => __("yay")],
    ["reaction" => "wow",    "color" => "yellow",  "title" => __("wow")],
    ["reaction" => "sad",    "color" => "yellow",  "title" => __("sad")],
    ["reaction" => "angry",  "color" => "orange",  "title" => __("angry")],
  ];
  return $reactions;
}


/**
 * get_reaction_details
 * 
 * @param string $reaction
 * @return array
 */
function get_reaction_details($reaction)
{
  global $reactions;
  foreach ($reactions as $_key => $_val) {
    if ($_val["reaction"] === $reaction) {
      return $reactions[$_key];
    }
  }
  return false;
}



/* ------------------------------- */
/* Censored Words */
/* ------------------------------- */

/**
 * censored_words
 * 
 * @param string $text
 * @return string
 */
function censored_words($text)
{
  global $system;
  if ($system['censored_words_enabled']) {
    $bad_words = explode(',', trim($system['censored_words']));
    if ($bad_words) {
      foreach ($bad_words as $word) {
        $word = trim($word);
        $pattern = '/\b' . $word . '\b/iu';
        $text = preg_replace($pattern, str_repeat('*', strlen($word)), $text);
      }
    }
  }
  return $text;
}



/* ------------------------------- */
/* Images */
/* ------------------------------- */

/**
 * get_picture
 * 
 * @param string $picture
 * @param string $type
 * @return string
 */
function get_picture($picture, $type)
{
  global $system;
  if ($picture == "") {
    switch ($type) {
      case 'page':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_page.jpg';
        break;

      case 'group':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_group.jpg';
        break;

      case 'event':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_event.jpg';
        break;

      case 'article':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_article.jpg';
        break;

      case 'movie':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_movie.jpg';
        break;

      case 'game':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_game.jpg';
        break;

      case 'package':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_package.png';
        break;

      case 'flag':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_flag.png';
        break;

      case 'system':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/svg/dashboard.svg';
        break;

      case '1':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_profile_male.svg';
        break;

      case '2':
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_profile_female.svg';
        break;

      default:
        $picture = $system['system_url'] . '/content/themes/' . $system['theme'] . '/images/blank_profile.svg';
        break;
    }
  } else {
    $picture = $system['system_uploads'] . '/' . $picture;
  }
  return $picture;
}


/**
 * save_picture_from_url
 * 
 * @param string $file
 * @param boolean $cropped
 * @return string
 */
function save_picture_from_url($file, $cropped = false, $resize = false)
{
  global $system;
  /* check & create uploads dir */
  $folder = 'photos';
  $directory = $folder . '/' . date('Y') . '/' . date('m') . '/';
  // init image & prepare image name & path
  require_once(ABSPATH . 'includes/class-image.php');
  $image = new Image($file);
  $prefix = $system['uploads_prefix'] . '_' . get_hash_token();
  if ($cropped) {
    $image_name = $directory . $prefix . "_cropped" . $image->_img_ext;
    if ($resize) {
      $image->resizeWidth($_POST['resize_width']);
    }
    $_POST['width'] = (isset($_POST['width'])) ? $_POST['width'] : $image->getWidth();
    $_POST['height'] = (isset($_POST['height'])) ? $_POST['height'] : $image->getHeight();
    $image->crop($_POST['width'], $_POST['height'], $_POST['x'], $_POST['y']);
  } else {
    $image_name = $directory . $prefix . $image->_img_ext;
  }
  $path = ABSPATH . $system['uploads_directory'] . '/' . $image_name;
  /* set uploads directory */
  if (!file_exists(ABSPATH . $system['uploads_directory'] . '/' . $folder)) {
    @mkdir(ABSPATH . $system['uploads_directory'] . '/' . $folder, 0777, true);
  }
  if (!file_exists(ABSPATH . $system['uploads_directory'] . '/' . $folder . '/' . date('Y'))) {
    @mkdir(ABSPATH . $system['uploads_directory'] . '/' . $folder . '/' . date('Y'), 0777, true);
  }
  if (!file_exists($system['uploads_directory'] . '/' . $folder . '/' . date('Y') . '/' . date('m'))) {
    @mkdir(ABSPATH . $system['uploads_directory'] . '/' . $folder . '/' . date('Y') . '/' . date('m'), 0777, true);
  }
  /* save the new image */
  $image->save($path, $system['uploads_quality']);
  /* Cloud Storage */
  if ($system['s3_enabled']) {
    /* Amazon S3 */
    aws_s3_upload($path, $image_name);
  } elseif ($system['digitalocean_enabled']) {
    /* DigitalOcean */
    digitalocean_space_upload($path, $image_name);
  } elseif ($system['wasabi_enabled']) {
    /* Wasabi */
    wasabi_upload($path, $image_name);
  } elseif ($system['google_cloud_enabled']) {
    /* Google Cloud */
    google_upload($path, $image_name);
  } elseif ($system['ftp_enabled']) {
    /* FTP */
    ftp_upload($path, $image_name);
  }
  return $image_name;
}


/**
 * watermark_image
 * 
 * @param string $image_path
 * @param string $image_type
 * @return void
 */
function watermark_image($image_path, $image_type)
{
  global $system;
  if (!is_empty($system['watermark_icon'])) {
    try {
      $image = new claviska\SimpleImage();
      $image
        ->fromFile($image_path)
        ->autoOrient()
        ->overlay($system['system_uploads'] . "/" . $system['watermark_icon'], $system['watermark_position'], $system['watermark_opacity'], $system['watermark_xoffset'], $system['watermark_yoffset'])
        ->toFile($image_path, $image_type);
    } catch (Exception $e) {
      return $e->getMessage();
    }
  }
}



/* ------------------------------- */
/* Utilities */
/* ------------------------------- */

/**
 * get_ip
 * 
 * @return string
 */
function get_user_ip()
{
  /* handle CloudFlare IP addresses */
  return (isset($_SERVER["HTTP_CF_CONNECTING_IP"]) ? $_SERVER["HTTP_CF_CONNECTING_IP"] : $_SERVER['REMOTE_ADDR']);
}


/**
 * get_os
 * 
 * @return string
 */
function get_user_os()
{
  $os_platform = "Unknown OS Platform";
  $os_array = array(
    '/windows nt 10/i'      =>  'Windows 10',
    '/windows nt 6.3/i'     =>  'Windows 8.1',
    '/windows nt 6.2/i'     =>  'Windows 8',
    '/windows nt 6.1/i'     =>  'Windows 7',
    '/windows nt 6.0/i'     =>  'Windows Vista',
    '/windows nt 5.2/i'     =>  'Windows Server 2003/XP x64',
    '/windows nt 5.1/i'     =>  'Windows XP',
    '/windows xp/i'         =>  'Windows XP',
    '/windows nt 5.0/i'     =>  'Windows 2000',
    '/windows me/i'         =>  'Windows ME',
    '/win98/i'              =>  'Windows 98',
    '/win95/i'              =>  'Windows 95',
    '/win16/i'              =>  'Windows 3.11',
    '/macintosh|mac os x/i' =>  'Mac OS X',
    '/mac_powerpc/i'        =>  'Mac OS 9',
    '/linux/i'              =>  'Linux',
    '/ubuntu/i'             =>  'Ubuntu',
    '/iphone/i'             =>  'iPhone',
    '/ipod/i'               =>  'iPod',
    '/ipad/i'               =>  'iPad',
    '/android/i'            =>  'Android',
    '/blackberry/i'         =>  'BlackBerry',
    '/webos/i'              =>  'Mobile'
  );
  foreach ($os_array as $regex => $value) {
    if (preg_match($regex, $_SERVER['HTTP_USER_AGENT'])) {
      $os_platform = $value;
    }
  }
  return $os_platform;
}


/**
 * get_browser
 * 
 * @return string
 */
function get_user_browser()
{
  $browser = "Unknown Browser";
  $browser_array = array(
    '/msie/i'       =>  'Internet Explorer',
    '/firefox/i'    =>  'Firefox',
    '/safari/i'     =>  'Safari',
    '/chrome/i'     =>  'Chrome',
    '/edge/i'       =>  'Edge',
    '/opera/i'      =>  'Opera',
    '/netscape/i'   =>  'Netscape',
    '/maxthon/i'    =>  'Maxthon',
    '/konqueror/i'  =>  'Konqueror',
    '/mobile/i'     =>  'Handheld Browser'
  );
  foreach ($browser_array as $regex => $value) {
    if (preg_match($regex, $_SERVER['HTTP_USER_AGENT'])) {
      $browser = $value;
    }
  }
  return $browser;
}


/**
 * get_extension
 * 
 * @param string $path
 * @return string
 */
function get_extension($path)
{
  return strtolower(pathinfo($path, PATHINFO_EXTENSION));
}


/**
 * get_origin_url
 * 
 * @param string $url
 * @return string
 */
function get_origin_url($url)
{
  stream_context_set_default(array(
    'http' => array(
      'ignore_errors' => true,
      'method' => 'HEAD',
      'user_agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
    )
  ));
  $headers = get_headers($url, 1);
  if ($headers !== false && (isset($headers['location']) || isset($headers['Location']))) {
    $location = (isset($headers['location'])) ? $headers['location'] : $headers['Location'];
    return is_array($location) ? array_pop($location) : $location;
  }
  return $url;
}


/**
 * decode_urls
 * 
 * @param string $text
 * @return string
 */
function decode_urls($text)
{
  $text = preg_replace('/(https?:\/\/[^\s]+)/', "<a target='_blank' rel='nofollow' href=\"$1\">$1</a>", $text);
  return $text;
}


/**
 * get_url_text
 * 
 * @param string $string
 * @param integer $length
 * @return string
 */
function get_url_text($string, $length = 10)
{
  $string = htmlspecialchars_decode($string, ENT_QUOTES);
  $string = preg_replace('/[^\\pL\d]+/u', '-', $string);
  $string = trim($string, '-');
  $words = explode("-", $string);
  if (count($words) > $length) {
    $string = "";
    for ($i = 0; $i < $length; $i++) {
      $string .= "-" . $words[$i];
    }
    $string = trim($string, '-');
  }
  return $string;
}


/**
 * remove_querystring_var
 * 
 * @param string $url
 * @param string $key
 * @return string
 */
function remove_querystring_var($url, $key)
{
  $url = preg_replace('/(.*)(?|&)' . $key . '=[^&]+?(&)(.*)/i', '$1$2$4', $url . '&');
  $url = substr($url, 0, -1);
  return $url;
}


/**
 * get_snippet_text
 * 
 * @param string $string
 * @return string
 */
function get_snippet_text($string)
{
  $string = htmlspecialchars_decode($string, ENT_QUOTES);
  $string = strip_tags($string);
  return $string;
}


/**
 * get_tag
 * 
 * @param string $string
 * @return string
 */
function get_tag($string)
{
  $string = trim($string);
  $string = preg_replace('/\s+/', '_', $string);
  return $string;
}


/**
 * get_youtube_id
 * 
 * @param string $url
 * @param boolean $embed
 * @return string
 */
function get_youtube_id($url, $embed = true)
{
  if ($embed) {
    preg_match('/youtube\.com\/embed\/([^\&\?\/]+)/', $url, $id);
    return $id[1];
  } else {
    parse_str(parse_url($url, PHP_URL_QUERY), $id);
    return $id['v'];
  }
}


/**
 * get_vimeo_id
 * 
 * @param string $url
 * @return string
 */
function get_vimeo_id($url)
{
  return (int) substr(parse_url($url, PHP_URL_PATH), 1);
}


/**
 * get_video_type
 * 
 * @param string $url
 * @return string
 */
function get_video_type($url)
{
  if (strpos($url, 'youtube') > 0) {
    return 'youtube';
  } elseif (strpos($url, 'vimeo') > 0) {
    return 'vimeo';
  } else {
    return 'link';
  }
}


/**
 * get_array_key
 * 
 * @param array $array
 * @param integer $current
 * @param integer $offset
 * @return mixed
 */
function get_array_key($array, $current, $offset = 1)
{
  $keys = array_keys($array);
  $index = array_search($current, $keys);
  if (isset($keys[$index + $offset])) {
    return $keys[$index + $offset];
  }
  return false;
}


/**
 * print_money
 * 
 * @param string $amount
 * @param string $symbol
 * @param string $dir
 * @return string
 */

function print_money($amount, $symbol = null, $dir = null)
{
  global $system;
  $symbol = ($symbol) ? $symbol : $system['system_currency_symbol'];
  $dir = ($dir) ? $dir : $system['system_currency_dir'];
  if ($dir == "right") {
    return $amount . $symbol;
  } else {
    return $symbol . $amount;
  }
}
