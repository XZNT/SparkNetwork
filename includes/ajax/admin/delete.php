<?php

// fetch bootstrap
require('../../../bootstrap.php');

// check AJAX Request
is_ajax();

// valid inputs
if ($_POST['handle'] != "reports" && $_POST['handle'] != "user_points_reset") {
  if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
    _error(400);
  }
}

// check demo account
if ($user->_data['user_demo']) {
  modal("ERROR", __("Demo Restriction"), __("You can't do this with demo account"));
}

// handle delete
try {

  switch ($_POST['handle']) {

    case 'theme':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      /* check if this theme is the default one */
      $check_themes = $db->query(sprintf("SELECT COUNT(*) as count FROM system_themes WHERE system_themes.default = '1' and theme_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      if ($check_themes->fetch_assoc()['count'] > 0) {
        throw new Exception(__("This is your only default theme you need to mark other theme as default before change/delete this one"));
      }
      $db->query(sprintf("DELETE FROM system_themes WHERE theme_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'language':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM system_languages WHERE language_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'country':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM system_countries WHERE country_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'currency':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM system_currencies WHERE currency_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'gender':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM system_genders WHERE gender_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'user':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // check if changing the super admin user
      if ($user->_data['user_id'] != '1' && $_POST['id'] == '1') {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to edit this user"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete report */
      if (isset($_POST['node']) && is_numeric($_POST['node'])) {
        $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['node'], 'int'))) or _error("SQL_ERROR_THROWEN");
      }
      /* delete user */
      $user->delete_user($_POST['id']);
      break;

    case 'user_posts':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // check if changing the super admin user
      if ($user->_data['user_id'] != '1' && $_POST['id'] == '1') {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to edit this user"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete user posts */
      $user->delete_posts($_POST['id']);
      break;

    case 'session':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM users_sessions WHERE session_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'user_package':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("UPDATE users SET user_subscribed = '0', user_package = null, user_subscription_date = null, user_boosted_posts = '0', user_boosted_pages = '0' WHERE user_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'page':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete report */
      if (isset($_POST['node']) && is_numeric($_POST['node'])) {
        $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['node'], 'int'))) or _error("SQL_ERROR_THROWEN");
      }
      /* delete page */
      $user->delete_page($_POST['id']);
      break;

    case 'page_posts':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete page posts */
      $user->delete_posts($_POST['id'], 'page');
      break;

    case 'page_category':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $user->delete_category("pages_categories", $_POST['id']);
      break;

    case 'group':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete report */
      if (isset($_POST['node']) && is_numeric($_POST['node'])) {
        $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['node'], 'int'))) or _error("SQL_ERROR_THROWEN");
      }
      /* delete group */
      $user->delete_group($_POST['id']);
      break;

    case 'group_posts':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete group posts */
      $user->delete_posts($_POST['id'], 'group');
      break;

    case 'group_category':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $user->delete_category("groups_categories", $_POST['id']);
      break;

    case 'event':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete report */
      if (isset($_POST['node']) && is_numeric($_POST['node'])) {
        $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['node'], 'int'))) or _error("SQL_ERROR_THROWEN");
      }
      /* delete event */
      $user->delete_event($_POST['id']);
      break;

    case 'event_posts':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete event posts */
      $user->delete_posts($_POST['id'], 'event');
      break;

    case 'event_category':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $user->delete_category("events_categories", $_POST['id']);
      break;

    case 'blogs_category':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $user->delete_category("blogs_categories", $_POST['id']);
      break;

    case 'market_category':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $user->delete_category("market_categories", $_POST['id']);
      break;

    case 'offers_category':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $user->delete_category("offers_categories", $_POST['id']);
      break;

    case 'jobs_category':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $user->delete_category("jobs_categories", $_POST['id']);
      break;

    case 'forum':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete report */
      if (isset($_POST['node']) && is_numeric($_POST['node'])) {
        $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['node'], 'int'))) or _error("SQL_ERROR_THROWEN");
      }
      /* delete forum */
      $user->delete_forum($_POST['id']);
      break;

    case 'forum_thread':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete forum thread */
      $user->delete_forum_thread($_POST['id']);
      if (isset($_POST['node']) && is_numeric($_POST['node'])) {
        /* delete report */
        $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['node'], 'int'))) or _error("SQL_ERROR_THROWEN");
      }
      break;

    case 'forum_reply':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete report */
      if (isset($_POST['node']) && is_numeric($_POST['node'])) {
        $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['node'], 'int'))) or _error("SQL_ERROR_THROWEN");
      }
      /* delete forum reply */
      $user->delete_forum_reply($_POST['id']);
      break;

    case 'movie':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM movies WHERE movie_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'movie_genre':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM movies_genres WHERE genre_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'game':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM games WHERE game_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'ads_system':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM ads_system WHERE ads_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'package':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM packages WHERE package_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'apps_category':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $user->delete_category("developers_apps_categories", $_POST['id']);
      break;

    case 'report':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'reports':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query("DELETE FROM reports") or _error("SQL_ERROR_THROWEN");
      break;

    case 'report_category':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $user->delete_category("reports_categories", $_POST['id']);
      break;

    case 'post':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete report */
      if (isset($_POST['node']) && is_numeric($_POST['node'])) {
        $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['node'], 'int'))) or _error("SQL_ERROR_THROWEN");
      }
      /* delete post */
      $user->delete_post($_POST['id'], false);
      break;

    case 'comment':
      // check admin|moderator permission
      if (!$user->_is_admin && !$user->_is_moderator) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      // [BACKGROUND PROCESS]
      /* return async */
      return_json_async();
      /* delete report */
      if (isset($_POST['node']) && is_numeric($_POST['node'])) {
        $db->query(sprintf("DELETE FROM reports WHERE report_id = %s", secure($_POST['node'], 'int'))) or _error("SQL_ERROR_THROWEN");
      }
      /* delete comment */
      $user->delete_comment($_POST['id']);
      break;

    case 'blacklist_node':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM blacklist WHERE node_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'custom_field':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM custom_fields WHERE field_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      $db->query(sprintf("DELETE FROM custom_fields_values WHERE field_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'static_page':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM static_pages WHERE page_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'pattern':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM posts_colored_patterns WHERE pattern_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'widget':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM widgets WHERE widget_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'emoji':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM emojis WHERE emoji_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'sticker':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM stickers WHERE sticker_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'gift':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM gifts WHERE gift_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    case 'announcement':
      // check admin|moderator permission
      if (!$user->_is_admin) {
        modal("MESSAGE", __("System Message"), __("You don't have the right permission to access this"));
      }
      $db->query(sprintf("DELETE FROM announcements WHERE announcement_id = %s", secure($_POST['id'], 'int'))) or _error("SQL_ERROR_THROWEN");
      break;

    default:
      _error(400);
      break;
  }

  // return & exist
  return_json();
} catch (Exception $e) {
  modal("ERROR", __("Error"), $e->getMessage());
}
