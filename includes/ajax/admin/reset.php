<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// check admin|moderator permission
if (!$user->_is_admin) {
  modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
}

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

try {

  // check password
  $user->check_password($_POST['password_check']);

  // factory reset
  /* empty tables */
  $tables = [
    "ads_campaigns",
    "ads_system",
    "affiliates_payments",
    "announcements",
    "announcements_users",
    "bank_transfers",
    "blacklist",
    "coinpayments_transactions",
    "conversations",
    "conversations_calls_audio",
    "conversations_calls_video",
    "conversations_messages",
    "conversations_users",
    "custom_fields",
    "custom_fields_values",
    "developers_apps",
    "developers_apps_users",
    "events",
    "events_members",
    "followings",
    "forums",
    "forums_replies",
    "forums_threads",
    "friends",
    "funding_payments",
    "games",
    "games_players",
    "gifts",
    "groups",
    "groups_admins",
    "groups_members",
    "hashtags",
    "hashtags_posts",
    "invitation_codes",
    "movies",
    "notifications",
    "packages",
    "packages_payments",
    "pages",
    "pages_admins",
    "pages_invites",
    "pages_likes",
    "points_payments",
    "posts",
    "posts_articles",
    "posts_audios",
    "posts_comments",
    "posts_comments_reactions",
    "posts_files",
    "posts_funding",
    "posts_funding_donors",
    "posts_hidden",
    "posts_jobs",
    "posts_jobs_applications",
    "posts_links",
    "posts_live",
    "posts_live_users",
    "posts_media",
    "posts_offers",
    "posts_photos",
    "posts_photos_albums",
    "posts_photos_reactions",
    "posts_polls",
    "posts_polls_options",
    "posts_polls_options_users",
    "posts_products",
    "posts_reactions",
    "posts_saved",
    "posts_videos",
    "reports",
    "stories",
    "stories_media",
    "users_affiliates",
    "users_blocks",
    "users_gifts",
    "users_pokes",
    "users_searches",
    "verification_requests",
    "wallet_payments",
    "wallet_transactions",
    "widgets",
  ];
  foreach ($tables as $table) {
    $db->query(sprintf("TRUNCATE %s", $table)) or _error("SQL_ERROR_THROWEN");
  }
  /* delete all other users */
  $db->query(sprintf("DELETE FROM users WHERE user_id != %s", secure($user->_data['user_id'], "int"))) or _error("SQL_ERROR_THROWEN");
  /* delete all other users sessions */
  $db->query(sprintf("DELETE FROM users_sessions WHERE user_id != %s", secure($user->_data['user_id'], "int"))) or _error("SQL_ERROR_THROWEN");
  /* reset admin account details */
  $db->query(sprintf("UPDATE users SET 
		user_live_requests_counter = '0', 
		user_live_requests_lastid = '0', 
		user_live_messages_counter = '0', 
		user_live_messages_lastid = '0', 
		user_live_notifications_counter = '0', 
		user_live_notifications_lastid = '0', 
		user_picture = NULL, 
		user_picture_id = NULL, 
		user_cover = NULL, 
		user_cover_id = NULL, 
		user_cover_position = NULL, 
		user_album_pictures = NULL, 
		user_album_covers = NULL, 
		user_album_timeline = NULL, 
		user_pinned_post = NULL, 
		user_affiliate_balance = '0', 
		user_funding_balance = '0', 
		user_wallet_balance = '0', 
		user_points = '0' 
		WHERE user_id = %s", secure($user->_data['user_id'], "int"))) or _error("SQL_ERROR_THROWEN");

  // return & exit
  return_json();
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
