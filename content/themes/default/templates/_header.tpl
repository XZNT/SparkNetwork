{if !$user->_logged_in}

  <body data-hash-tok="{$session_hash['token']}" data-hash-pos="{$session_hash['position']}" class="{if $system['theme_mode_night']}night-mode{/if} visitor n_chat {if ($page == 'index' && !$system['newsfeed_public']) || $page == 'sign'}index-body{/if}" {if ($page == 'index' || $page == 'sign') && !$system['system_wallpaper_default'] && $system['system_wallpaper']} style="background-image: url('{$system['system_uploads']}/{$system['system_wallpaper']}'); background-size: cover;" {/if} {if $page == 'profile' && $system['system_profile_background_enabled'] && $profile['user_profile_background']}style="background: url({$profile['user_profile_background']}) fixed !important; background-size: 100% auto;" {/if}>
  {else}

    <body data-hash-tok="{$session_hash['token']}" data-hash-pos="{$session_hash['position']}" data-chat-enabled="{$user->_data['user_chat_enabled']}" class="{if $system['theme_mode_night']}night-mode{/if} {if !$system['chat_enabled']}n_chat{/if}{if $system['activation_enabled'] && !$system['activation_required'] && !$user->_data['user_activated']} n_activated{/if}{if !$system['system_live']} n_live{/if}" {if $page == 'profile' && $system['system_profile_background_enabled'] && $profile['user_profile_background']}style="background: url({$profile['user_profile_background']}) fixed !important; background-size: 100% auto;" {/if} {if $page == "share" && $url}onload="initialize_scraper()" {/if}>
    {/if}
    <!-- main wrapper -->
    <div class="main-wrapper">
      {if $user->_logged_in && $system['activation_enabled'] && !$system['activation_required'] && !$user->_data['user_activated']}
        <!-- top-bar -->
        <div class="top-bar">
          <div class="container">
            <div class="row">
              <div class="col-sm-7 d-none d-sm-block">
                {if $system['activation_type'] == "email"}
                  {__("Please go to")} <span class="text-primary">{$user->_data['user_email']}</span> {__("to complete the activation process")}.
                {else}
                  {__("Please check the SMS on your phone")} <strong>{$user->_data['user_phone']}</strong> {__("to complete the activation process")}.
                {/if}
              </div>
              <div class="col-sm-5">
                {if $system['activation_type'] == "email"}
                  <span class="text-link" data-toggle="modal" data-url="core/activation_email_resend.php">
                    {__("Resend Verification Email")}
                  </span>
                  -
                  <span class="text-link" data-toggle="modal" data-url="#activation-email-reset">
                    {__("Change Email")}
                  </span>
                {else}
                  <span class="btn btn-info btn-sm mr10" data-toggle="modal" data-url="#activation-phone">{__("Enter Code")}</span>
                  {if $user->_data['user_phone']}
                    <span class="text-link" data-toggle="modal" data-url="core/activation_phone_resend.php">
                      {__("Resend SMS")}
                    </span>
                    -
                  {/if}
                  <span class="text-link" data-toggle="modal" data-url="#activation-phone-reset">
                    {__("Change Phone Number")}
                  </span>
                {/if}
              </div>
            </div>
          </div>
        </div>
        <!-- top-bar -->
      {/if}

      {if !$system['system_live']}
        <!-- top-bar alert-->
        <div class="top-bar danger">
          <div class="container">
            <i class="fa fa-exclamation-triangle fa-lg pr5"></i>
            <span class="d-none d-sm-inline">{__("The system has been shutted down")}.</span>
            <span>{__("Turn it on from")}</span> <a href="{$system['system_url']}/admincp/settings">{__("Admin Panel")}</a>
          </div>
        </div>
        <!-- top-bar alert-->
      {/if}

      <!-- main-header -->
      <div class="main-header">
        <div class="container">
          <div class="row">

            <div class="{if !$user->_logged_in}col-6{/if} col-md-4 col-lg-3 {if $user->_logged_in}d-none d-md-block{/if}">
              <!-- logo-wrapper -->
              <div class="logo-wrapper">

                {if !$user->_logged_in && $system['newsfeed_public']}
                  <!-- menu-icon -->
                  <a href="#" data-toggle="offcanvas" class="menu-icon d-block d-md-none">
                    {include file='__svg_icons.tpl' icon="header-menu" width="20px" height="20px" style="fill: #fff"}
                  </a>
                  <!-- menu-icon -->
                {/if}

                <!-- logo -->
                <a href="{$system['system_url']}" class="logo {if !$user->_logged_in && $system['newsfeed_public']}with-menu-icon{/if}">
                  {if $system['system_logo']}
                    <img class="img-fluid" src="{$system['system_uploads']}/{$system['system_logo']}" alt="{__($system['system_title'])}" title="{__($system['system_title'])}">
                  {else}
                    {__($system['system_title'])}
                  {/if}
                </a>
                <!-- logo -->

                {if $user->_logged_in}
                  <!-- home-icon -->
                  <a href="{$system['system_url']}" class="home-icon">
                    {include file='__svg_icons.tpl' icon="header-home" width="20px" height="20px" style="fill: #fff"}
                  </a>
                  <!-- home-icon -->
                {/if}

              </div>
              <!-- logo-wrapper -->
            </div>

            <div class="{if !$user->_logged_in}col-6{/if} col-md-8 col-lg-9">
              <div class="row">
                <div class="col-md-7 col-lg-8">
                  <!-- search-wrapper -->
                  {if $user->_logged_in || (!$user->_logged_in && $system['system_public']) }
                    {include file='_header.search.tpl'}
                  {/if}
                  <!-- search-wrapper -->
                </div>
                <div class="col-md-5 col-lg-4">
                  <!-- navbar-wrapper -->
                  <div class="navbar-wrapper">
                    <ul class="clearfix">
                      {if $user->_logged_in}
                        <!-- bars -->
                        <li class="d-block d-md-none">
                          <a href="#" data-toggle="offcanvas">
                            {include file='__svg_icons.tpl' icon="header-menu" width="20px" height="20px" style="fill: #fff"}
                          </a>
                        </li>
                        <!-- bars -->

                        <!-- home -->
                        <li class="d-block d-md-none">
                          <a href="{$system['system_url']}">
                            {include file='__svg_icons.tpl' icon="header-home" width="20px" height="20px" style="fill: #fff"}
                          </a>
                        </li>
                        <!-- home -->

                        {if $user->_data['can_add_stories'] || $user->_data['can_write_articles'] || $user->_data['can_sell_products'] || $user->_data['can_raise_funding'] || $user->_data['can_create_ads'] || $user->_data['can_create_pages'] || $user->_data['can_create_groups'] || $user->_data['can_create_events']}
                          <!-- add -->
                          <li class="d-none d-xl-block dropdown">
                            <a href="#" data-toggle="dropdown" data-display="static">
                              {include file='__svg_icons.tpl' icon="header-plus" width="20px" height="20px" style="fill: #fff"}
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                              {if $user->_data['can_add_stories']}
                                <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/story.php?do=create">
                                  <i class="fas fa-photo-video fa-fw mr10" style="color: #673ab7;"></i>{__("Create Story")}
                                </div>
                              {/if}
                              {if $user->_data['can_write_articles']}
                                <a class="dropdown-item" href="{$system['system_url']}/blogs/new">
                                  <i class="fas fa-blog fa-fw mr10" style="color: #f25e4e;"></i>{__("Create Blog")}
                                </a>
                              {/if}
                              {if $user->_data['can_sell_products']}
                                <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/product.php?do=create">
                                  <i class="fas fa-cart-plus fa-fw mr10" style="color: #2b53a4;"></i>{__("Create Product")}
                                </div>
                              {/if}
                              {if $user->_data['can_raise_funding']}
                                <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/funding.php?do=create">
                                  <i class="fas fa-hand-holding-usd fa-fw mr10" style="color: #4caf50;"></i>{__("Create Funding")}
                                </div>
                              {/if}
                              {if $user->_data['can_create_ads']}
                                <a class="dropdown-item" href="{$system['system_url']}/ads/new">
                                  <i class="fas fa-bullseye fa-fw mr10" style="color: #f44336;"></i>{__("Create Ads")}
                                </a>
                              {/if}
                              {if $user->_data['can_create_pages']}
                                <div class="dropdown-item pointer" data-toggle="modal" data-url="pages_groups_events/add.php?type=page">
                                  <i class="fas fa-flag fa-fw mr10" style="color: #2196f3;"></i>{__("Create Page")}
                                </div>
                              {/if}
                              {if $user->_data['can_create_groups']}
                                <div class="dropdown-item pointer" data-toggle="modal" data-url="pages_groups_events/add.php?type=group">
                                  <i class="fas fa-users fa-fw mr10" style="color: #2b53a4;"></i>{__("Create Group")}
                                </div>
                              {/if}
                              {if $user->_data['can_create_events']}
                                <div class="dropdown-item pointer" data-toggle="modal" data-url="pages_groups_events/add.php?type=event">
                                  <i class="fas fa-calendar-plus fa-fw mr10" style="color: #f79f58;"></i>{__("Create Event")}
                                </div>
                              {/if}
                            </div>
                          </li>
                          <!-- add -->
                        {/if}

                        <!-- friend requests -->
                        {include file='_header.friend_requests.tpl'}
                        <!-- friend requests -->

                        <!-- messages -->
                        {include file='_header.messages.tpl'}
                        <!-- messages -->

                        <!-- notifications -->
                        {include file='_header.notifications.tpl'}
                        <!-- notifications -->

                        <!-- search -->
                        <li class="d-block d-md-none">
                          <a href="{$system['system_url']}/search">
                            {include file='__svg_icons.tpl' icon="header-search" width="20px" height="20px" style="fill: #fff"}
                          </a>
                        </li>
                        <!-- search -->

                        <!-- user-menu -->
                        <li class="dropdown">
                          <a href="#" class="dropdown-toggle user-menu" data-toggle="dropdown" data-display="static">
                            <img src="{$user->_data['user_picture']}">
                          </a>
                          <div class="dropdown-menu dropdown-menu-right">
                            {if $system['packages_enabled'] && !$user->_data['user_subscribed']}
                              <a class="dropdown-item" href="{$system['system_url']}/packages">{__("Upgrade to Pro")}</a>
                            {/if}
                            {if $system['points_enabled'] || $system['wallet_enabled'] || $user->_data['can_raise_funding']}
                              {if $system['points_enabled']}
                                <a class="dropdown-item" href="{$system['system_url']}/settings/points">{__("Points")}: <span class="badge badge-info">{$user->_data['user_points']}</span></a>
                              {/if}
                              {if $system['wallet_enabled']}
                                <a class="dropdown-item" href="{$system['system_url']}/wallet">{__("Wallet")}: <span class="badge badge-success">{print_money($user->_data['user_wallet_balance']|number_format:2)}</span></a>
                              {/if}
                              {if $user->_data['can_raise_funding']}
                                <a class="dropdown-item" href="{$system['system_url']}/settings/funding">{__("Funding")}: <span class="badge badge-success">{print_money($user->_data['user_funding_balance']|number_format:2)}</span></a>
                              {/if}
                              <div class="dropdown-divider"></div>
                            {/if}
                            <a class="dropdown-item" href="{$system['system_url']}/{$user->_data['user_name']}">{__("Profile")}</a>
                            <a class="dropdown-item" href="{$system['system_url']}/settings">{__("Settings")}</a>
                            <a class="dropdown-item" href="{$system['system_url']}/settings/privacy">{__("Privacy")}</a>
                            {if $user->_is_admin}
                              <div class="dropdown-divider"></div>
                              <a class="dropdown-item" href="{$system['system_url']}/admincp">{__("Admin Panel")}</a>
                            {elseif $user->_is_moderator}
                              <div class="dropdown-divider"></div>
                              <a class="dropdown-item" href="{$system['system_url']}/modcp">{__("Moderator Panel")}</a>
                            {/if}
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="{$system['system_url']}/signout">{__("Log Out")}</a>
                            <div class="dropdown-divider"></div>
                            <div class="dropdown-item pointer" data-toggle="modal" data-url="#keyboard-shortcuts" data-size="small">
                              {__("Keyboard Shortcuts")}
                              <span class="float-right">
                                <i class="fas fa-keyboard"></i>
                              </span>
                            </div>
                            <div class="dropdown-divider"></div>
                            {if $system['themes'] && count($system['themes']) > 1}
                              <div class="dropdown-item pointer" data-toggle="modal" data-url="#theme-switcher">
                                {__("Theme Switcher")}
                                <span class="float-right">
                                  <i class="fas fa-paint-roller"></i>
                                </span>
                              </div>
                            {/if}
                            {if $system['system_theme_mode_select']}
                              {if $system['theme_mode_night']}
                                <div class="dropdown-item pointer js_theme-mode" data-mode="day">
                                  <span class="js_theme-mode-text">{__("Day Mode")}</span>
                                  <span class="float-right">
                                    <i class="js_theme-mode-icon fas fa-sun"></i>
                                  </span>
                                </div>
                              {else}
                                <div class="dropdown-item pointer js_theme-mode" data-mode="night">
                                  <span class="js_theme-mode-text">{__("Night Mode")}</span>
                                  <span class="float-right">
                                    <i class="js_theme-mode-icon fas fa-moon"></i>
                                  </span>
                                </div>
                              {/if}
                            {/if}
                          </div>
                        </li>
                        <!-- user-menu -->

                      {else}

                        <li class="dropdown float-right">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-display="static">
                            <span>{__("Join")}</span>
                          </a>
                          <div class="dropdown-menu dropdown-menu-right">
                            <a class="dropdown-item" href="{$system['system_url']}/signin">{__("Login")}</a>
                            {if $system['registration_enabled']}
                              <a class="dropdown-item" href="{$system['system_url']}/signup">{__("Register")}</a>
                            {/if}
                            {if ($system['themes'] && count($system['themes']) > 1) || $system['system_theme_mode_select']}
                              <div class="dropdown-divider"></div>
                            {/if}
                            {if $system['themes'] && count($system['themes']) > 1}
                              <div class="dropdown-item pointer" data-toggle="modal" data-url="#theme-switcher">
                                {__("Theme Switcher")}
                                <span class="float-right">
                                  <i class="fas fa-paint-roller"></i>
                                </span>
                              </div>
                            {/if}
                            {if $system['system_theme_mode_select']}
                              {if $system['theme_mode_night']}
                                <div class="dropdown-item pointer js_theme-mode" data-mode="day">
                                  <span class="js_theme-mode-text">{__("Day Mode")}</span>
                                  <span class="float-right">
                                    <i class="js_theme-mode-icon fas fa-sun"></i>
                                  </span>
                                </div>
                              {else}
                                <div class="dropdown-item pointer js_theme-mode" data-mode="night">
                                  <span class="js_theme-mode-text">{__("Night Mode")}</span>
                                  <span class="float-right">
                                    <i class="js_theme-mode-icon fas fa-moon"></i>
                                  </span>
                                </div>
                              {/if}
                            {/if}
                          </div>
                        </li>

                      {/if}
                    </ul>
                  </div>
                  <!-- navbar-wrapper -->
                </div>
              </div>

            </div>
          </div>

        </div>
      </div>
      <!-- main-header -->

      <!-- ads -->
      {include file='_ads.tpl' _ads=$ads_master['header'] _master=true}
<!-- ads -->