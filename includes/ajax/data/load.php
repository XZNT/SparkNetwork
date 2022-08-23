<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// user access (exclude these loads from login)
if ($system["system_public"] && !in_array($_POST['get'], ["newsfeed", "posts_profile", "posts_page", "posts_group", "posts_event", "suggested_pages", "suggested_groups", "suggested_events", "articles", "category_articles", "fundings", "games", "search_posts", "search_articles", "search_users", "search_pages", "search_groups", "search_events"])) {
  user_access(true);
}

// valid inputs
if (!isset($_POST['offset']) || !is_numeric($_POST['offset'])) {
  _error(400);
}

try {

  // initialize the return array
  $return = array();

  // initialize the attach type
  $append = true;

  // get data
  switch ($_POST['get']) {
    case 'newsfeed':
    case 'popular':
    case 'discover':
    case 'saved':
    case 'memories':
    case 'boosted':
      /* get [newsfeed || popular || discover || saved || memories || boosted] */
      $data = $user->get_posts(array('get' => $_POST['get'], 'filter' => $_POST['filter'], 'offset' => $_POST['offset']));

      // get ads campaigns
      if ($user->_logged_in) {
        $ads_campaigns = $user->ads_campaigns('newsfeed');
        /* assign variables */
        $smarty->assign('ads_campaigns', $ads_campaigns);
      }

      // get ads
      switch ($_POST['offset']) {
        case '1':
          $ads = $user->ads('newfeed_1');
          break;

        case '2':
          $ads = $user->ads('newfeed_2');
          break;

        case '3':
          $ads = $user->ads('newfeed_3');
          break;
      }
      /* assign variables */
      $smarty->assign('ads', $ads);
      break;

    case 'posts_profile':
    case 'posts_page':
    case 'posts_group':
    case 'posts_group_pending':
    case 'posts_group_pending_all':
    case 'posts_event':
    case 'posts_event_pending':
    case 'posts_event_pending_all':
    case 'posts_event':
      /* get [posts_profile || posts_page || posts_group || posts_group_pending || posts_group_pending_all || posts_event || posts_event_pending ||  posts_event_pending_all] */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_posts(array('get' => $_POST['get'], 'filter' => $_POST['filter'], 'offset' => $_POST['offset'], 'id' => $_POST['id']));

      // get ads campaigns
      $ads_campaigns = $user->ads_campaigns('newsfeed');
      /* assign variables */
      $smarty->assign('ads_campaigns', $ads_campaigns);

      // get ads
      switch ($_POST['offset']) {
        case '1':
          $ads = $user->ads('newfeed_1');
          break;

        case '2':
          $ads = $user->ads('newfeed_2');
          break;

        case '3':
          $ads = $user->ads('newfeed_3');
          break;
      }
      /* assign variables */
      $smarty->assign('ads', $ads);
      break;

    case 'shares':
      /* get who shares the post */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->who_shares($_POST['id'], $_POST['offset']);
      break;

    case 'articles':
      /* get articles */
      $data = $user->get_articles(array('offset' => $_POST['offset']));
      break;

    case 'category_articles':
      /* get category articles */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_articles(array("category" => $_POST['id'], 'offset' => $_POST['offset']));
      break;

    case 'fundings':
      /* get fundings */
      $data = $user->get_fundings(array('offset' => $_POST['offset']));
      break;

    case 'post_comments':
      /* get post comments */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_comments($_POST['id'], $_POST['offset'], true, false);
      break;

    case 'post_comments_top':
      /* get post comments top */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_comments($_POST['id'], $_POST['offset'], true, false, [], true);
      break;

    case 'photo_comments':
      /* get photo comments */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_comments($_POST['id'], $_POST['offset'], false, false);
      break;

    case 'photo_comments_top':
      /* get photo comments top */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_comments($_POST['id'], $_POST['offset'], false, false, [], true);
      break;

    case 'comment_replies':
      /* get comment replies */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $append = false;
      $data = $user->get_replies($_POST['id'], $_POST['offset'], false);
      break;

    case 'photos':
      /* get photos */
      /* check uid */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_photos($_POST['id'], $_POST['type'], $_POST['offset'], false);
      $context = ($_POST['type'] == "album") ? "album" : "photos";
      $smarty->assign('context', $context);
      break;

    case 'albums':
      /* get albums */
      /* check uid */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_albums($_POST['id'], $_POST['type'], $_POST['offset']);
      break;

    case 'videos':
      /* get videos */
      /* check uid */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_videos($_POST['id'], $_POST['type'], $_POST['offset']);
      break;

    case 'post_reactions':
      /* get who reacted to the post */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->who_reacts(['post_id' => $_POST['id'], 'reaction_type' => $_POST['filter'], 'offset' => $_POST['offset']]);
      break;

    case 'photo_reactions':
      /* get who reacted to the photo */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->who_reacts(['photo_id' => $_POST['id'], 'reaction_type' => $_POST['filter'], 'offset' => $_POST['offset']]);
      break;

    case 'comment_reactions':
      /* get who reacted to the comment */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->who_reacts(['comment_id' => $_POST['id'], 'reaction_type' => $_POST['filter'], 'offset' => $_POST['offset']]);
      break;

    case 'donors':
      /* get donors */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->who_donates($_POST['id'], $_POST['offset']);
      break;

    case 'voters':
      /* get voters */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->who_votes($_POST['id'], $_POST['offset']);
      break;

    case 'blocks':
      /* get blocks */
      $data = $user->get_blocked($_POST['offset']);
      break;

    case 'affiliates':
      /* get affiliates */
      /* check uid */
      if (!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
        _error(400);
      }
      $data = $user->get_affiliates($_POST['uid'], $_POST['offset']);
      break;

    case 'friend_requests':
      /* get friend requests */
      $data = $user->get_friend_requests($_POST['offset']);
      break;

    case 'friend_requests_sent':
      /* get friend requests sent */
      $data = $user->get_friend_requests_sent($_POST['offset']);
      break;

    case 'mutual_friends':
      /* get mutual friends */
      /* check uid */
      if (!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
        _error(400);
      }
      $data = $user->get_mutual_friends($_POST['uid'], $_POST['offset']);
      break;

    case 'new_people':
      /* get new people */
      $data = $user->get_new_people($_POST['offset']);
      break;

    case 'friends':
      /* get friends */
      /* check uid */
      if (!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
        _error(400);
      }
      $data = $user->get_friends($_POST['uid'], $_POST['offset']);
      break;

    case 'followers':
      /* get followers */
      /* check uid */
      if (!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
        _error(400);
      }
      $data = $user->get_followers($_POST['uid'], $_POST['offset']);
      break;

    case 'followings':
      /* get followings */
      /* check uid */
      if (!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
        _error(400);
      }
      $data = $user->get_followings($_POST['uid'], $_POST['offset']);
      break;

    case 'page_invites':
      /* get page invites */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_page_invites($_POST['id'], $_POST['offset']);
      break;

    case 'page_members':
      /* get page members */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_page_members($_POST['id'], $_POST['offset']);
      break;

    case 'page_admins':
      /* get page admins */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_page_admins($_POST['id'], $_POST['offset']);
      break;

    case 'group_members':
      /* get group members */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_group_members($_POST['id'], $_POST['offset']);
      break;

    case 'group_members_manage':
      /* get group members manage */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_group_members($_POST['id'], $_POST['offset'], true);
      break;

    case 'group_admins':
      /* get group admins */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_group_admins($_POST['id'], $_POST['offset']);
      break;


    case 'group_invites':
      /* get group invites */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_group_invites($_POST['id'], $_POST['offset']);
      break;

    case 'group_requests':
      /* get group requests */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_group_requests($_POST['id'], $_POST['offset']);
      break;

    case 'event_going':
      /* get event going members */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_event_members($_POST['id'], 'going', $_POST['offset']);
      break;

    case 'event_interested':
      /* get event interested members */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_event_members($_POST['id'], 'interested', $_POST['offset']);
      break;

    case 'event_invited':
      /* get event invited members */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_event_members($_POST['id'], 'invited', $_POST['offset']);
      break;

    case 'event_invites':
      /* get event invites */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_event_invites($_POST['id'], $_POST['offset']);
      break;

    case 'pages':
      /* get viewer pages */
      $data = $user->get_pages(array('offset' => $_POST['offset']));
      break;

    case 'suggested_pages':
      /* get suggested pages */
      $data = $user->get_pages(array('suggested' => true, 'offset' => $_POST['offset']));
      break;

    case 'liked_pages':
    case 'profile_pages':
      /* get [liked_pages || profile_pages] */
      /* check uid */
      if (!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
        _error(400);
      }
      $data = $user->get_pages(array('user_id' => $_POST['uid'], 'offset' => $_POST['offset']));
      break;

    case 'boosted_pages':
      /* get boosted pages */
      $data = $user->get_pages(array('boosted' => true, 'offset' => $_POST['offset']));
      break;

    case 'groups':
      /* get viewer groups */
      $data = $user->get_groups(array('offset' => $_POST['offset']));
      break;

    case 'suggested_groups':
      /* get suggested groups */
      $data = $user->get_groups(array('suggested' => true, 'offset' => $_POST['offset']));
      break;

    case 'joined_groups':
    case 'profile_groups':
      /* get [joined_groups || profile_groups] */
      /* check uid */
      if (!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
        _error(400);
      }
      $data = $user->get_groups(array('user_id' => $_POST['uid'], 'offset' => $_POST['offset']));
      break;

    case 'events':
      /* get viewer events */
      $data = $user->get_events(array('offset' => $_POST['offset']));
      break;

    case 'suggested_events':
      /* get suggested events */
      $data = $user->get_events(array('suggested' => true, 'offset' => $_POST['offset']));
      break;

    case 'going_events':
      /* get going events */
      $data = $user->get_events(array('filter' => 'going', 'offset' => $_POST['offset']));
      break;

    case 'interested_events':
      /* get interested events */
      $data = $user->get_events(array('filter' => 'interested', 'offset' => $_POST['offset']));
      break;

    case 'invited_events':
      /* get invited events */
      $data = $user->get_events(array('filter' => 'invited', 'offset' => $_POST['offset']));
      break;

    case 'profile_events':
      /* get profile events */
      /* check uid */
      if (!isset($_POST['uid']) || !is_numeric($_POST['uid'])) {
        _error(400);
      }
      $data = $user->get_events(array('user_id' => $_POST['uid'], 'offset' => $_POST['offset']));
      break;

    case 'games':
      /* get games */
      $data = $user->get_games($_POST['offset']);
      break;

    case 'played_games':
      /* get played games */
      $data = $user->get_games($_POST['offset'], true);
      break;

    case 'notifications':
      /* get notifications */
      $data = $user->get_notifications($_POST['offset']);
      break;

    case 'conversations':
      /* get conversations */
      $data = $user->get_conversations($_POST['offset']);
      break;

    case 'messages':
      /* get conversation messages */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $append = false;
      $data = $user->get_conversation_messages($_POST['id'], $_POST['offset']);
      break;

    case 'job_candidates':
      /* get job candidates  */
      /* check id */
      if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        _error(400);
      }
      $data = $user->get_job_candidates($_POST['id'], $_POST['offset']);
      break;

    case 'search_posts':
    case 'search_articles':
    case 'search_users':
    case 'search_pages':
    case 'search_groups':
    case 'search_events':
      /* get search results */
      /* check query */
      if (!isset($_POST['filter'])) {
        _error(400);
      }
      $tab = str_replace("search_", "", $_POST['get']);
      $data = $user->search($_POST['filter'], $tab, $_POST['offset']);
      break;

    default:
      /* bad request */
      _error(400);
      break;
  }

  // handle data
  if ($data) {
    /* assign variables */
    $smarty->assign('offset', $_POST['offset']);
    $smarty->assign('get', $_POST['get']);
    $smarty->assign('data', $data);
    /* return */
    $return['append'] = $append;
    $return['data'] = $smarty->fetch("ajax.load_more.tpl");
  }

  // return & exit
  return_json($return);
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
