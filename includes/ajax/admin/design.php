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

// handle design
try {

  /* prepare */
  $_POST['system_theme_night_on'] = (isset($_POST['system_theme_night_on'])) ? '1' : '0';
  $_POST['system_theme_mode_select'] = (isset($_POST['system_theme_mode_select'])) ? '1' : '0';
  $_POST['system_wallpaper_default'] = (isset($_POST['system_wallpaper_default'])) ? '1' : '0';
  $_POST['system_favicon_default'] = (isset($_POST['system_favicon_default'])) ? '1' : '0';
  $_POST['system_favicon'] = ($_POST['system_favicon_default']) ? '' : $_POST['system_favicon'];
  $_POST['system_ogimage_default'] = (isset($_POST['system_ogimage_default'])) ? '1' : '0';
  $_POST['system_ogimage'] = ($_POST['system_ogimage_default']) ? '' : $_POST['system_ogimage'];
  $_POST['play_store_badge_enabled'] = (isset($_POST['play_store_badge_enabled'])) ? '1' : '0';
  $_POST['appgallery_badge_enabled'] = (isset($_POST['appgallery_badge_enabled'])) ? '1' : '0';
  $_POST['app_store_badge_enabled'] = (isset($_POST['app_store_badge_enabled'])) ? '1' : '0';
  $_POST['css_customized'] = (isset($_POST['css_customized'])) ? '1' : '0';
  /* update */
  update_system_options([
    'system_theme_night_on' => secure($_POST['system_theme_night_on']),
    'system_theme_mode_select' => secure($_POST['system_theme_mode_select']),
    'system_logo' => secure($_POST['system_logo']),
    'system_wallpaper_default' => secure($_POST['system_wallpaper_default']),
    'system_wallpaper' => secure($_POST['system_wallpaper']),
    'system_favicon_default' => secure($_POST['system_favicon_default']),
    'system_favicon' => secure($_POST['system_favicon']),
    'system_ogimage_default' => secure($_POST['system_ogimage_default']),
    'system_ogimage' => secure($_POST['system_ogimage']),
    'play_store_badge_enabled' => secure($_POST['play_store_badge_enabled']),
    'appgallery_badge_enabled' => secure($_POST['appgallery_badge_enabled']),
    'appgallery_store_link' => secure($_POST['appgallery_store_link']),
    'play_store_link' => secure($_POST['play_store_link']),
    'app_store_badge_enabled' => secure($_POST['app_store_badge_enabled']),
    'app_store_link' => secure($_POST['app_store_link']),
    'css_customized' => secure($_POST['css_customized']),
    'css_background' => secure($_POST['css_background']),
    'css_link_color' => secure($_POST['css_link_color']),
    'css_header' => secure($_POST['css_header']),
    'css_header_search' => secure($_POST['css_header_search']),
    'css_header_search_color' => secure($_POST['css_header_search_color']),
    'css_btn_primary' => secure($_POST['css_btn_primary']),
    'css_custome_css' => secure($_POST['css_custome_css']),
    'custome_js_header' => secure($_POST['custome_js_header']),
    'custome_js_footer' => secure($_POST['custome_js_footer'])
  ]);
  /* return */
  return_json(array('callback' => 'window.location.reload();'));
} catch (Exception $e) {
  return_json(array('error' => true, 'message' => $e->getMessage()));
}
