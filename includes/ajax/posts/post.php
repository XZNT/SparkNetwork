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

// valid inputs
if (!in_array($_POST['handle'], array('me', 'user', 'page', 'group', 'event'))) {
  _error(400);
}
/* filter anonymous */
/* filter link */
if (isset($_POST['link'])) {
  $_POST['link'] = json_decode($_POST['link']);
  if (!is_object($_POST['link'])) {
    _error(400);
  }
}
/* filter photos */
$photos = array();
if (isset($_POST['photos'])) {
  $_POST['photos'] = json_decode($_POST['photos']);
  if (!is_object($_POST['photos'])) {
    _error(400);
  }
  /* filter the photos */
  foreach ($_POST['photos'] as $photo) {
    $photos[] = (array) $photo;
  }
  if (count($photos) == 0) {
    _error(400);
  }
}
/* filter voice_notes */
if (isset($_POST['voice_notes'])) {
  $_POST['voice_notes'] = json_decode($_POST['voice_notes']);
  if (!is_object($_POST['voice_notes'])) {
    _error(400);
  }
}
/* filter poll options */
if (isset($_POST['poll_options'])) {
  $_POST['poll_options'] = json_decode($_POST['poll_options']);
  if (!is_array($_POST['poll_options'])) {
    _error(400);
  }
  /* check the options */
  $options = array();
  foreach ($_POST['poll_options'] as $option) {
    if (strlen($option) > 255) {
      modal("MESSAGE", __("Poll option too long"), __("The poll option you provided is too long. Please try again"));
    }
    if (in_array($option, $options)) {
      modal("MESSAGE", __("Poll Option Already Added"), __("This option was already added to the poll"));
    }
    if (!is_empty($option)) {
      $options[] = $option;
    }
  }
  /* check the question */
  if (is_empty($_POST['message'])) {
    modal("MESSAGE", __("Poll Text Needed"), __("Ask a question so people know what your poll is about"));
  }
}
/* filter video */
if (isset($_POST['video'])) {
  $_POST['video'] = json_decode($_POST['video']);
  if (!is_object($_POST['video'])) {
    _error(400);
  }
}
/* filter audio */
if (isset($_POST['audio'])) {
  $_POST['audio'] = json_decode($_POST['audio']);
  if (!is_object($_POST['audio'])) {
    _error(400);
  }
}
/* filter file */
if (isset($_POST['file'])) {
  $_POST['file'] = json_decode($_POST['file']);
  if (!is_object($_POST['file'])) {
    _error(400);
  }
}

try {

  // initialize the return array
  $return = $inputs = array();

  // publisher
  /* valid inputs */
  $inputs['is_anonymous'] = '0';
  if ($_POST['handle'] == 'user') {
    if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
      _error(400);
    }
    $inputs['id'] = $_POST['id'];
    /* if privacy set and not valid */
    $_POST['privacy'] = ($system['newsfeed_source'] == "all_posts") ? "public" : $_POST['privacy'];
    if (!isset($_POST['privacy']) || !in_array($_POST['privacy'], array('friends', 'public'))) {
      _error(400);
    }
    $inputs['privacy'] = $_POST['privacy'];
    $_get = 'posts_profile';
  } elseif ($_POST['handle'] == 'page') {
    if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
      _error(400);
    }
    $inputs['id'] = $_POST['id'];
    $inputs['privacy'] = 'public';
    $_get = 'posts_page';
  } elseif ($_POST['handle'] == 'group') {
    if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
      _error(400);
    }
    $inputs['id'] = $_POST['id'];
    $inputs['privacy'] = 'custom';
    $_get = 'posts_group';
  } elseif ($_POST['handle'] == 'event') {
    if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
      _error(400);
    }
    $inputs['id'] = $_POST['id'];
    $inputs['privacy'] = 'custom';
    $_get = 'posts_event';
  } else {
    /* check newsfeed_source */
    $_POST['privacy'] = ($system['newsfeed_source'] == "all_posts") ? "public" : $_POST['privacy'];
    /* if privacy set and not valid */
    if (!isset($_POST['privacy']) || !in_array($_POST['privacy'], array('me', 'friends', 'public'))) {
      _error(400);
    }
    $inputs['privacy'] = $_POST['privacy'];
    $_get = 'newfeed';
    /* if is_anonymous set and enabled */
    if ($system['anonymous_mode'] && $_POST['handle'] == 'me' && $_POST['is_anonymous'] == "true") {
      $inputs['is_anonymous'] = '1';
      /* set album empty */
      $_POST['album'] = "";
      /* set privacy to public */
      $inputs['privacy'] = 'public';
    }
  }
  /* prepare inputs */
  $inputs['handle'] = $_POST['handle'];
  $inputs['message'] = $_POST['message'];
  $inputs['link'] = $_POST['link'];
  $inputs['photos'] = $photos;
  $inputs['album'] = $_POST['album'];
  $inputs['feeling_action'] = $_POST['feeling_action'];
  $inputs['feeling_value'] = $_POST['feeling_value'];
  $inputs['location'] = $_POST['location'];
  $inputs['colored_pattern'] = $_POST['colored_pattern'];
  $inputs['poll_options'] = $options;
  $inputs['video'] = $_POST['video'];
  $inputs['video_thumbnail'] = $_POST['video_thumbnail'];
  $inputs['audio'] = ($_POST['voice_notes']) ? $_POST['voice_notes'] : $_POST['audio'];
  $inputs['file'] = $_POST['file'];
  /* publish */
  $post = $user->publisher($inputs);
  /* assign variables */
  $smarty->assign('post', $post);
  $smarty->assign('_get', $_get);
  /* return */
  $return['post'] = $smarty->fetch("__feeds_post.tpl");

  // return & exit
  return_json($return);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
