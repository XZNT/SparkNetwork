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

// check if funding enabled
if (!$system['funding_enabled']) {
  modal("MESSAGE", __("Error"), __("This feature has been disabled by the admin"));
}

try {

  // initialize the return array
  $return = array();

  switch ($_REQUEST['do']) {
    case 'create':
      // check funding permission
      if (!$user->_data['can_raise_funding']) {
        modal("MESSAGE", __("Error"), __("You don't have the permission to do this"));
      }

      // return
      $return['template'] = $smarty->fetch("ajax.funding.publisher.tpl");
      $return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template); initialize_modal();";
      break;

    case 'publish':
      // check funding permission
      if (!$user->_data['can_raise_funding']) {
        modal("MESSAGE", __("Error"), __("You don't have the permission to do this"));
      }

      // valid inputs
      /* check funding title */
      if (is_empty($_POST['title'])) {
        return_json(array('error' => true, 'message' => __("Add title for your funding request")));
      }
      if (strlen($_POST['title']) < 3) {
        return_json(array('error' => true, 'message' => __("Minimum funding title is 3 characters")));
      }
      if (strlen($_POST['title']) > 100) {
        return_json(array('error' => true, 'message' => __("Maximum funding title is 100 characters")));
      }
      /* check funding amount */
      if (is_empty($_POST['amount']) || !is_numeric($_POST['amount']) || $_POST['amount'] <= 0) {
        return_json(array('error' => true, 'message' => __("Please add valid funding amount")));
      }
      /* check funding description */
      if (is_empty($_POST['description'])) {
        return_json(array('error' => true, 'message' => __("Add description for your funding request")));
      }
      if (strlen($_POST['description']) < 32) {
        return_json(array('error' => true, 'message' => __("Minimum funding description is 32 characters")));
      }
      if (strlen($_POST['description']) > 1000) {
        return_json(array('error' => true, 'message' => __("Maximum funding description is 1000 characters")));
      }
      /* check funding cover image */
      if (is_empty($_POST['cover_image'])) {
        return_json(array('error' => true, 'message' => __("Add cover image for your funding request")));
      }

      /* prepare inputs */
      $inputs['is_anonymous'] = '0';
      $inputs['message'] = $_POST['description'];
      $inputs['funding'] = (object)$_POST;

      // publish
      $post = $user->publisher($inputs);

      // return
      $return['callback'] = "window.location = '" . $system['system_url'] . "/posts/" . $post['post_id'] . "';";
      break;

    case 'edit':
      // valid inputs
      if (!isset($_GET['post_id']) || !is_numeric($_GET['post_id'])) {
        _error(400);
      }

      // get post
      $post = $user->get_post($_GET['post_id']);
      if (!$post) {
        _error(400);
      }
      /* assign variables */
      $smarty->assign('post', $post);

      // return
      $return['template'] = $smarty->fetch("ajax.funding.editor.tpl");
      $return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template); initialize_modal();";
      break;

    case 'donate':
      // valid inputs
      if (!isset($_GET['post_id']) || !is_numeric($_GET['post_id'])) {
        _error(400);
      }
      /* check amount */
      if (!isset($_POST['amount']) || !is_numeric($_POST['amount']) || $_POST['amount'] <= 0) {
        throw new Exception(__("You must enter valid amount of money"));
      }

      // get post
      $post = $user->get_post($_GET['post_id']);
      if (!$post) {
        _error(400);
      }

      // return
      modal("#payment", "{'handle': 'donate', 'id': '" . $_GET['post_id'] . "', 'price': '" . $_POST['amount'] . "'}");
      break;

    default:
      _error(400);
      break;
  }

  // return & exit
  return_json($return);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
