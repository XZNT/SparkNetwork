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

// check if offers enabled
if (!$system['pages_enabled'] || !$system['offers_enabled']) {
  modal("MESSAGE", __("Error"), __("This feature has been disabled by the admin"));
}

try {

  // initialize the return array
  $return = array();

  switch ($_GET['do']) {
    case 'create':
      // valid inputs
      if (!isset($_GET['page_id']) || !is_numeric($_GET['page_id'])) {
        _error(400);
      }

      // check page adminship
      if (!$user->check_page_adminship($user->_data['user_id'], $_GET['page_id'])) {
        modal("MESSAGE", __("Error"), __("You are not authorized to do this"));
      }

      // assign variables
      $smarty->assign('page_id', $_GET['page_id']);
      $smarty->assign('offers_categories', $user->get_categories("offers_categories"));
      $smarty->assign('custom_fields', $user->get_custom_fields(array("for" => "offer")));

      // return
      $return['template'] = $smarty->fetch("ajax.offer.publisher.tpl");
      $return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template); initialize_modal();";
      break;

    case 'publish':
      // valid inputs
      if (!isset($_POST['page_id']) || !is_numeric($_POST['page_id'])) {
        _error(400);
      }
      /* check discount type */
      switch ($_POST['discount_type']) {
        case 'discount_percent':
          if (is_empty($_POST['discount_percent']) || !is_numeric($_POST['discount_percent']) || $_POST['discount_percent'] > 99 || $_POST['discount_percent'] < 1) {
            return_json(array('error' => true, 'message' => __("Select valid discount percent")));
          }
          break;

        case 'discount_amount':
          if (is_empty($_POST['discount_amount']) || !is_numeric($_POST['discount_amount']) || $_POST['discount_amount'] <= 0) {
            return_json(array('error' => true, 'message' => __("Enter valid discount amount")));
          }
          break;

        case 'buy_get_discount':
          if (is_empty($_POST['buy_x']) || !is_numeric($_POST['buy_x']) || $_POST['buy_x'] <= 0) {
            return_json(array('error' => true, 'message' => __("Enter valid Buy X amount")));
          }
          if (is_empty($_POST['get_y']) || !is_numeric($_POST['get_y']) || $_POST['get_y'] <= 0) {
            return_json(array('error' => true, 'message' => __("Enter valid Get Y amount")));
          }
          break;

        case 'spend_get_off':
          if (is_empty($_POST['spend_x']) || !is_numeric($_POST['spend_x']) || $_POST['spend_x'] <= 0) {
            return_json(array('error' => true, 'message' => __("Enter valid Spend X amount")));
          }
          if (is_empty($_POST['amount_y']) || !is_numeric($_POST['amount_y']) || $_POST['amount_y'] <= 0) {
            return_json(array('error' => true, 'message' => __("Enter valid Amount Y amount")));
          }
          break;

        case 'free_shipping':
          # do nothing
          break;

        default:
          return_json(array('error' => true, 'message' => __("Select valid discount type for your offer")));
          break;
      }
      /* check end date */
      if (is_empty($_POST['end_date'])) {
        return_json(array('error' => true, 'message' => __("Add end date for your offer")));
      }
      if (is_empty($_POST['end_date'])) {
        return_json(array('error' => true, 'message' => __("Add end date for your offer")));
      }
      if (strtotime(set_datetime($_POST['end_date'])) <= strtotime($date)) {
        throw new Exception(__("End date must be after today datetime"));
      }
      /* check offer category */
      if (is_empty($_POST['category'])) {
        return_json(array('error' => true, 'message' => __("select valid category for your offer")));
      }
      if (!$user->get_category("offers_categories", $_POST['category'])) {
        return_json(array('error' => true, 'message' => __("select valid category for your offer")));
      }
      /* check offer title */
      if (is_empty($_POST['title'])) {
        return_json(array('error' => true, 'message' => __("Add title for your offer")));
      }
      if (strlen($_POST['title']) < 3) {
        return_json(array('error' => true, 'message' => __("Minimum offer title is 3 characters")));
      }
      if (strlen($_POST['title']) > 100) {
        return_json(array('error' => true, 'message' => __("Maximum offer title is 100 characters")));
      }
      /* check offer description */
      if (is_empty($_POST['description'])) {
        return_json(array('error' => true, 'message' => __("Add description for your offer")));
      }
      if (strlen($_POST['description']) < 32) {
        return_json(array('error' => true, 'message' => __("Minimum offer description is 32 characters")));
      }
      if (strlen($_POST['description']) > 1000) {
        return_json(array('error' => true, 'message' => __("Maximum offer description is 1000 characters")));
      }
      /* check offer thumbnail */
      if (is_empty($_POST['thumbnail'])) {
        return_json(array('error' => true, 'message' => __("Add thumbnail for your offer")));
      }
      /* set custom fields */
      try {
        $inputs['custom_fields'] = $user->set_custom_fields($_POST, 'offer');
      } catch (Exception $e) {
        return_json(array('error' => true, 'message' => $e->getMessage()));
      }

      /* prepare inputs */
      $inputs['handle'] = "page";
      $inputs['id'] = $_POST['page_id'];
      $inputs['is_anonymous'] = '0';
      $inputs['message'] = $_POST['description'];
      $inputs['offer'] = (object)$_POST;

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
      $smarty->assign('offers_categories', $user->get_categories("offers_categories"));
      $smarty->assign('custom_fields', $user->get_custom_fields(array("for" => "offer", "get" => "settings", "node_id" => $_GET['post_id'])));

      // return
      $return['template'] = $smarty->fetch("ajax.offer.editor.tpl");
      $return['callback'] = "$('#modal').modal('show'); $('.modal-content:last').html(response.template); initialize_modal();";
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
