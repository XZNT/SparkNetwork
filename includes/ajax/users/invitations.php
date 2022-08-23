<?php
// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true);

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

// handle invitation
switch ($_GET['do']) {
  case 'generate':
    try {

      // initialize the return array
      $return = array();

      // generate new invitation code
      $code = $user->generate_invitation_code();
      /* assign variables */
      $smarty->assign('code', $code);
      /* return */
      $return['template'] = $smarty->fetch("ajax.invitations.tpl");
      $return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template);";

      // return & exit
      return_json($return);
    } catch (Exception $e) {
      modal("ERROR", __("Error"), $e->getMessage());
    }
    break;

  case 'share':
    try {

      // initialize the return array
      $return = array();

      // prepare email
      /* assign variables */
      $smarty->assign('code', $_GET['code']);
      /* return */
      $return['template'] = $smarty->fetch("ajax.invitations.tpl");
      $return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template);";

      // return & exit
      return_json($return);
    } catch (Exception $e) {
      modal("ERROR", __("Error"), $e->getMessage());
    }
    break;

  case 'send':
    try {

      // send invitation code
      switch ($_POST['send_method']) {
        case 'email':
          $user->send_invitation_email($_POST['email'], $_POST['code']);
          break;

        case 'sms':
          $user->send_invitation_sms($_POST['phone'], $_POST['code']);
          break;
      }

      // return
      return_json(array('success' => true, 'message' => __("Your invitation has been sent")));
    } catch (Exception $e) {
      return_json(array('error' => true, 'message' => $e->getMessage()));
    }
    break;

  default:
    _error(400);
    break;
}
