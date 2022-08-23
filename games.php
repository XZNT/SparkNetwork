<?php
// fetch bootloader
require('bootloader.php');

// games enabled
if (!$system['games_enabled']) {
  _error(404);
}

try {

  // get view content
  switch ($_GET['view']) {
    case '':
      // user access
      if ($user->_logged_in || !$system['system_public']) {
        user_access();
      }

      // page header
      page_header(__("Discover Games"));

      // get games
      $games = $user->get_games();
      /* assign variables */
      $smarty->assign('games', $games);
      $smarty->assign('get', "games");
      break;

    case 'played':
      // user access
      user_access();

      // page header
      page_header(__("Your Games"));

      // get games
      $games = $user->get_games(0, true);
      /* assign variables */
      $smarty->assign('games', $games);
      $smarty->assign('get', "played_games");
      break;

    case 'game':
      // user access
      if ($user->_logged_in || !$system['system_public']) {
        user_access();
      }

      // games permission
      if ($user->_logged_in) {
        if (!$user->_data['can_play_games']) {
          _error('PERMISSION');
        }
      } else {
        if ($system['games_permission'] != "everyone") {
          _error('PERMISSION');
        }
      }

      // get game
      $game = $user->get_game($_GET['game_id']);
      if (!$game) {
        _error(404);
      }
      /* assign variables */
      $smarty->assign('game', $game);

      // page header
      page_header($game['title'], $game['description'], $game['thumbnail']);
      break;

    default:
      _error(404);
      break;
  }
  /* assign variables */
  $smarty->assign('view', $_GET['view']);
} catch (Exception $e) {
  _error(__("Error"), $e->getMessage());
}

// page footer
page_footer("games");
