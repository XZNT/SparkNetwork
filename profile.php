<?php
// fetch bootloader
require('bootloader.php');

// user access
if ($user->_logged_in || !$system['system_public']) {
  user_access();
}

// check username
if (is_empty($_GET['username']) || !valid_username($_GET['username'])) {
  _error(404);
}

try {

  // [1] get main profile info
  $get_profile = $db->query(sprintf("SELECT users.*, picture_photo.source as user_picture_full, picture_photo_post.privacy as user_picture_privacy, cover_photo.source as user_cover_full, cover_photo_post.privacy as cover_photo_privacy, packages.name as package_name, packages.color as package_color FROM users LEFT JOIN posts_photos as picture_photo ON users.user_picture_id = picture_photo.photo_id LEFT JOIN posts as picture_photo_post ON picture_photo.post_id = picture_photo_post.post_id LEFT JOIN posts_photos as cover_photo ON users.user_cover_id = cover_photo.photo_id LEFT JOIN posts as cover_photo_post ON cover_photo.post_id = cover_photo_post.post_id LEFT JOIN packages ON users.user_subscribed = '1' AND users.user_package = packages.package_id WHERE users.user_name = %s", secure($_GET['username']))) or _error("SQL_ERROR_THROWEN");
  if ($get_profile->num_rows == 0) {
    _error(404);
  }
  $profile = $get_profile->fetch_assoc();
  /* check if banned by the system */
  if ($user->banned($profile['user_id'])) {
    if ($profile['user_banned_message']) {
      _error("BANNED_USER", $profile['user_banned_message']);
    } else {
      _error(404);
    }
  }
  /* check if blocked by the viewer */
  if ($user->blocked($profile['user_id'])) {
    _error(404);
  }
  /* check username case */
  if (strtolower($_GET['username']) == strtolower($profile['user_name']) && $_GET['username'] != $profile['user_name']) {
    redirect('/' . $profile['user_name']);
  }
  /* get profile name */
  $profile['name'] = ($system['show_usernames_enabled']) ? $profile['user_name'] : $profile['user_firstname'] . " " . $profile['user_lastname'];
  /* get profile picture */
  $profile['user_picture_default'] = ($profile['user_picture']) ? false : true;
  $profile['user_picture'] = get_picture($profile['user_picture'], $profile['user_gender']);
  $profile['user_picture_full'] = ($profile['user_picture_full']) ? $system['system_uploads'] . '/' . $profile['user_picture_full'] : $profile['user_picture_full'];
  $profile['user_picture_lightbox'] = $user->check_privacy($profile['user_picture_privacy'], $profile['user_id']);
  /* get profile cover */
  $profile['user_cover_default'] = ($profile['user_cover']) ? false : true;
  $profile['user_cover'] = ($profile['user_cover']) ? $system['system_uploads'] . '/' . $profile['user_cover'] : $profile['user_cover'];
  $profile['user_cover_full'] = ($profile['user_cover_full']) ? $system['system_uploads'] . '/' . $profile['user_cover_full'] : $profile['user_cover_full'];
  $profile['user_cover_lightbox'] = $user->check_privacy($profile['cover_photo_privacy'], $profile['user_id']);
  /* get user gender */
  $profile['user_gender'] = $user->get_gender($profile['user_gender']);
  /* get profile background */
  $profile['user_profile_background'] = ($profile['user_profile_background']) ? $system['system_uploads'] . '/' . $profile['user_profile_background'] : $profile['user_profile_background'];
  /* get profile friends count */
  $friends_count = $user->get_friends_count($profile['user_id']);
  /* get the connection &  mutual friends */
  if ($user->_logged_in && $profile['user_id'] != $user->_data['user_id']) {
    /* get the connection */
    $profile['we_friends'] = $user->friendship_approved($profile['user_id']);
    $profile['he_request'] = $user->is_friend_request($profile['user_id']);
    $profile['i_request'] = $user->is_friend_request_sent($profile['user_id']);
    $profile['i_follow'] = $user->is_following($profile['user_id']);
    $profile['friendship_declined'] = $user->friendship_declined($profile['user_id']);
    $profile['i_poked'] = $user->is_poked($profile['user_id']);
    /* get mutual friends */
    if ($friends_count <= 500) {
      $profile['mutual_friends_count'] = $user->get_mutual_friends_count($profile['user_id']);
      $profile['mutual_friends'] = $user->get_mutual_friends($profile['user_id']);
    }
  }

  // [2] get view content
  switch ($_GET['view']) {
    case '':
      /* profile completion */
      /* get the step value */

      if ($profile['user_id'] == $user->_data['user_id']) {
        $steps_missed = 0;
        $steps_requried = 3; /* there is 3 required fields already */
        /* [1] check profile picture */
        if ($profile['user_picture_default']) {
          $steps_missed++;
        }
        /* [2] check profile cover */
        if ($profile['user_cover_default']) {
          $steps_missed++;
        }
        /* [3] check birthdate */
        if (!$profile['user_birthdate']) {
          $steps_missed++;
        }
        /* [4] check biography */
        if ($system['biography_info_enabled']) {
          $steps_requried++;
          if (!$profile['user_biography']) {
            $steps_missed++;
          }
        }
        /* [5] check relationship */
        if ($system['relationship_info_enabled']) {
          $steps_requried++;
          if (!$profile['user_relationship']) {
            $steps_missed++;
          }
        }
        /* [6] check work */
        if ($system['work_info_enabled']) {
          $steps_requried++;
          if (!$profile['user_work_title'] || !$profile['user_work_place']) {
            $steps_missed++;
          }
        }
        /* [7] check location */
        if ($system['location_info_enabled']) {
          $steps_requried++;
          if (!$profile['user_current_city'] || !$profile['user_hometown']) {
            $steps_missed++;
          }
        }
        /* [8] check education */
        if ($system['education_info_enabled']) {
          $steps_requried++;
          if (!$profile['user_edu_major'] || !$profile['user_edu_school']) {
            $steps_missed++;
          }
        }
        $profile['profile_completion'] = round(100 - ($steps_missed * (100 / $steps_requried)));
      }

      /* get followers count */
      $profile['followers_count'] = $user->get_followers_count($profile['user_id']);

      /* get custom fields */
      $smarty->assign('custom_fields', $user->get_custom_fields(array("for" => "user", "get" => "profile", "node_id" => $profile['user_id'])));

      /* gifts system */
      if ($system['gifts_enabled']) {
        /* get gifts */
        $gifts = $user->get_gifts();
        /* assign variables */
        $smarty->assign('gifts', $gifts);

        /* get gift */
        if (isset($_GET['gift']) && is_numeric($_GET['gift'])) {
          $gift = $user->get_gift($_GET['gift']);
          /* assign variables */
          $smarty->assign('gift', $gift);
        }
      }

      /* get friends */
      $profile['friends'] = $user->get_friends($profile['user_id']);
      if ($profile['friends']) {
        $profile['friends_count'] = $friends_count;
      }

      /* get photos */
      $profile['photos'] = $user->get_photos($profile['user_id']);

      /* get pages */
      if ($system['pages_enabled']) {
        $profile['pages'] = $user->get_pages(array('user_id' => $profile['user_id'], 'results' => $system['min_results_even']));
      }

      /* get groups */
      if ($system['groups_enabled']) {
        $profile['groups'] = $user->get_groups(array('user_id' => $profile['user_id'], 'results' => $system['min_results_even']));
      }

      /* get events */
      if ($system['events_enabled']) {
        $profile['events'] = $user->get_events(array('user_id' => $profile['user_id'], 'results' => $system['min_results_even']));
      }

      /* get pinned post */
      $pinned_post = $user->get_post($profile['user_pinned_post']);
      $smarty->assign('pinned_post', $pinned_post);

      /* prepare publisher */
      $smarty->assign('feelings', get_feelings());
      $smarty->assign('feelings_types', get_feelings_types());
      if ($system['colored_posts_enabled']) {
        $smarty->assign('colored_patterns', $user->get_posts_colored_patterns());
      }

      /* get posts */
      $posts = $user->get_posts(array('get' => 'posts_profile', 'id' => $profile['user_id']));
      /* assign variables */
      $smarty->assign('posts', $posts);
      break;

    case 'friends':
      /* get friends */
      $profile['friends'] = $user->get_friends($profile['user_id']);
      if ($profile['friends']) {
        $profile['friends_count'] = $friends_count;
      }
      break;

    case 'followers':
      /* get followers count */
      $profile['followers_count'] = $user->get_followers_count($profile['user_id']);
      /* get followers */
      if ($profile['followers_count'] > 0) {
        $profile['followers'] = $user->get_followers($profile['user_id']);
      }
      break;

    case 'followings':
      /* get followings count */
      $profile['followings_count'] = $user->get_followings_count($profile['user_id']);
      /* get followings */
      if ($profile['followings_count'] > 0) {
        $profile['followings'] = $user->get_followings($profile['user_id']);
      }
      break;

    case 'photos':
      /* get photos */
      $profile['photos'] = $user->get_photos($profile['user_id']);
      break;

    case 'albums':
      /* get albums */
      $profile['albums'] = $user->get_albums($profile['user_id']);
      break;

    case 'album':
      /* get album */
      $album = $user->get_album($_GET['id']);
      if (!$album || $album['in_group'] || $album['user_type'] == "page" || ($album['user_type'] == "user" && $album['user_id'] != $profile['user_id'])) {
        _error(404);
      }
      /* assign variables */
      $smarty->assign('album', $album);
      break;

    case 'videos':
      /* get videos */
      $profile['videos'] = $user->get_videos($profile['user_id']);
      break;

    case 'likes':
      /* check if pages disabled */
      if (!$system['pages_enabled']) {
        _error(404);
      }

      /* get pages */
      $profile['pages'] = $user->get_pages(array('user_id' => $profile['user_id']));
      break;

    case 'groups':
      /* check if groups disabled */
      if (!$system['groups_enabled']) {
        _error(404);
      }

      /* get groups */
      $profile['groups'] = $user->get_groups(array('user_id' => $profile['user_id']));
      break;

    case 'events':
      /* check if events disabled */
      if (!$system['events_enabled']) {
        _error(404);
      }

      /* get events */
      $profile['events'] = $user->get_events(array('user_id' => $profile['user_id']));
      break;

    default:
      _error(404);
      break;
  }

  // [3] profile visit notification
  if ($_GET['view'] == "" && $user->_logged_in && $system['profile_notification_enabled']) {
    $user->post_notification(array('to_user_id' => $profile['user_id'], 'action' => 'profile_visit'));
  }

  // recent rearches
  if (isset($_GET['ref']) && $_GET['ref'] == "qs") {
    $user->set_search_log($profile['user_id'], 'user');
  }
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page header
page_header($profile['name'], $profile['user_biography'], $profile['user_picture']);

// assign variables
$smarty->assign('profile', $profile);
$smarty->assign('view', $_GET['view']);

// page footer
page_footer("profile");
