<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access
user_access(true);

try {

  // initialize the return array
  $return = array();

  switch ($_POST['do']) {
    case 'start':
      // create live post
      $post_id = $user->create_live_post($_POST['agora_uid'], $_POST['agora_token'], $_POST['agora_channel_name'], $_POST['video_thumbnail'], $_POST['node'], $_POST['node_id']);

      // return
      $return['post_id'] = $post_id;
      break;

    case 'end':
      // update live post
      $user->end_live_post($_POST['post_id']);
      break;

    case 'join':
      // get live post
      $post = $user->get_post($_POST['post_id'], true, true);
      if (!$post) {
        throw new Exception(__("This live no longer exists"));
      }
      /* assign variables */
      $smarty->assign('post', $post);

      // join live post
      if (!$post['live']['live_ended']) {
        $user->join_live_post($_POST['post_id']);
      }

      // return
      $return['agora_audience_uid'] = $post['live']['agora_audience_uid'];
      $return['agora_audience_token'] = $post['live']['agora_audience_token'];
      $return['agora_channel_name'] = $post['live']['agora_channel_name'];
      $return['live_ended'] = ($post['live']['live_ended']) ? true : false;
      $return['lightbox'] = $smarty->fetch("ajax.lightbox-live.tpl");
      break;

    case 'leave':
      // leave live post
      $user->leave_live_post($_POST['post_id']);
      break;

    case 'stats':
      // leave live post
      $stats = $user->get_live_post_stats($_POST['post_id'], $_POST['last_comment_id']);
      /* assign variables */
      $smarty->assign('comments', $stats['comments']);

      // return
      $return['live_count'] = $stats['live_count'];
      $return['comments'] = $smarty->fetch("ajax.live.comments.tpl");
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
