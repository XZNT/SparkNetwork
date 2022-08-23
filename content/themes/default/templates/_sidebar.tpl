<div class="card main-side-nav-card">
  <div class="card-body with-nav">
    <ul class="main-side-nav">

      <!-- basic -->
      {if $user->_logged_in}
        <li>
          <a href="{$system['system_url']}/{$user->_data['user_name']}">
            <img class="rounded-circle" src="{$user->_data.user_picture}" alt="">
            <span>{$user->_data['name']}</span>
          </a>
        </li>

        <li>
          <a href="{$system['system_url']}/messages">
            {include file='__svg_icons.tpl' icon="chat" class="mr10" width="24px" height="24px"}
            {__("Messages")}
          </a>
        </li>

        <li>
          <a href="{$system['system_url']}/settings">
            {include file='__svg_icons.tpl' icon="settings" class="mr10" width="24px" height="24px"}
            {__("Settings")}
          </a>
        </li>

        {if $user->_is_admin}
          <li>
            <a href="{$system['system_url']}/admincp">
              {include file='__svg_icons.tpl' icon="dashboard" class="mr10" width="24px" height="24px"}
              {__("Admin Panel")}
            </a>
          </li>
        {elseif $user->_is_moderator}
          <li>
            <a href="{$system['system_url']}/modcp">
              {include file='__svg_icons.tpl' icon="dashboard" class="mr10" width="24px" height="24px"}
              {__("Moderator Panel")}
            </a>
          </li>
        {/if}
      {/if}
      <!-- basic -->

      <!-- favorites -->
      <li class="ptb5">
        <strong><small class="text-muted">{__("favorites")|upper}</small></strong>
      </li>

      <li {if $page == "index" && ($view == "" || $view == "discover" || $view == "popular")}class="active" {/if}>
        {if !$user->_logged_in || (!$system['popular_posts_enabled'] && !$system['discover_posts_enabled'])}
          <a href="{$system['system_url']}">
            {include file='__svg_icons.tpl' icon="newsfeed" class="mr10" width="24px" height="24px"}
            {__("News Feed")}
          </a>
        {else}
          <a href="#newsfeed" data-toggle="collapse" {if $page == "index" && ($view == "discover" || $view == "popular")}aria-expanded="true" {/if}>
            {include file='__svg_icons.tpl' icon="newsfeed" class="mr10" width="24px" height="24px"}
            {__("News Feed")}
          </a>
          <div class='collapse {if $page == "index" && ($view == "discover" || $view == "popular")}show{/if}' id="newsfeed">
            <ul>
              <li {if $page == "index" && $view == ""}class="active" {/if}>
                <a href="{$system['system_url']}">
                  {include file='__svg_icons.tpl' icon="posts_recent" class="mr10" width="24px" height="24px"}
                  {__("Recent Updates")}
                </a>
              </li>
              {if $system['popular_posts_enabled']}
                <li {if $page == "index" && $view == "popular"}class="active" {/if}>
                  <a href="{$system['system_url']}/popular">
                    {include file='__svg_icons.tpl' icon="popularity" class="mr10" width="24px" height="24px"}
                    {__("Popular Posts")}
                  </a>
                </li>
              {/if}
              {if $system['discover_posts_enabled']}
                <li {if $page == "index" && $view == "discover"}class="active" {/if}>
                  <a href="{$system['system_url']}/discover">
                    {include file='__svg_icons.tpl' icon="posts_discover" class="mr10" width="24px" height="24px"}
                    {__("Discover Posts")}
                  </a>
                </li>
              {/if}
            </ul>
          </div>
        {/if}
      </li>

      {if $user->_data['can_write_articles']}
        <li {if $page == "index" && $view == "articles"}class="active" {/if}>
          <a href="{$system['system_url']}/articles">
            {include file='__svg_icons.tpl' icon="articles" class="mr10" width="24px" height="24px"}
            {__("My Articles")}
          </a>
        </li>
      {/if}

      {if $user->_data['can_sell_products']}
        <li {if $page == "index" && $view == "products"}class="active" {/if}>
          <a href="{$system['system_url']}/products">
            {include file='__svg_icons.tpl' icon="products" class="mr10" width="24px" height="24px"}
            {__("My Products")}
          </a>
        </li>
      {/if}

      {if $user->_data['can_raise_funding']}
        <li {if $page == "index" && $view == "funding_requests"}class="active" {/if}>
          <a href="{$system['system_url']}/funding_requests">
            {include file='__svg_icons.tpl' icon="money-bag" class="mr10" width="24px" height="24px"}
            {__("My Funding")}
          </a>
        </li>
      {/if}

      {if $user->_logged_in}
        <li {if $page == "index" && $view == "saved"}class="active" {/if}>
          <a href="{$system['system_url']}/saved">
            {include file='__svg_icons.tpl' icon="saved" class="mr10" width="24px" height="24px"}
            {__("Saved Posts")}
          </a>
        </li>
      {/if}

      {if $user->_logged_in}
        {if $system['memories_enabled']}
          <li {if $page == "index" && $view == "memories"}class="active" {/if}>
            <a href="{$system['system_url']}/memories">
              {include file='__svg_icons.tpl' icon="memories" class="mr10" width="24px" height="24px"}
              {__("Memories")}
            </a>
          </li>
        {/if}
      {/if}
      <!-- favorites -->

      <!-- advertising -->
      {if $user->_logged_in}
        {if $system['can_create_ads'] || $system['wallet_enabled'] || $system['packages_enabled']}
          <li class="ptb5">
            <small class="text-muted">{__("Advertising")|upper}</small>
          </li>

          {if $user->_data['can_create_ads']}
            <li {if $page == "ads"}class="active" {/if}>
              <a href="{$system['system_url']}/ads">
                {include file='__svg_icons.tpl' icon="ads" class="mr10" width="24px" height="24px"}
                {__("Ads Manager")}
              </a>
            </li>
          {/if}

          {if $system['wallet_enabled']}
            <li {if $page == "wallet"}class="active" {/if}>
              <a href="{$system['system_url']}/wallet">
                {include file='__svg_icons.tpl' icon="wallet" class="mr10" width="24px" height="24px"}
                {__("Wallet")}
              </a>
            </li>
          {/if}

          {if $system['packages_enabled']}
            <li {if $page == "index" && $view == "boosted_posts"}class="active" {/if}>
              <a href="{$system['system_url']}/boosted/posts">
                {include file='__svg_icons.tpl' icon="boosted_posts" class="mr10" width="24px" height="24px"}
                {__("Boosted Posts")}
              </a>
            </li>

            {if $system['pages_enabled']}
              <li {if $page == "index" && $view == "boosted_pages"}class="active" {/if}>
                <a href="{$system['system_url']}/boosted/pages">
                  {include file='__svg_icons.tpl' icon="boosted_pages" class="mr10" width="24px" height="24px"}
                  {__("Boosted Pages")}
                </a>
              </li>
            {/if}
          {/if}
        {/if}
      {/if}
      <!-- advertising -->

      <!-- explore -->
      <li class="ptb5">
        <small class="text-muted">{__("explore")|upper}</small>
      </li>

      {if $user->_logged_in}
        <li {if $page == "people"}class="active" {/if}>
          <a href="{$system['system_url']}/people">
            {include file='__svg_icons.tpl' icon="find_people" class="mr10" width="24px" height="24px"}
            {__("People")}
          </a>
        </li>
      {/if}

      {if $system['pages_enabled']}
        <li {if $page == "pages"}class="active" {/if}>
          <a href="{$system['system_url']}/pages">
            {include file='__svg_icons.tpl' icon="pages" class="mr10" width="24px" height="24px"}
            {__("Pages")}
          </a>
        </li>
      {/if}

      {if $system['groups_enabled']}
        <li {if $page == "groups"}class="active" {/if}>
          <a href="{$system['system_url']}/groups">
            {include file='__svg_icons.tpl' icon="groups" class="mr10" width="24px" height="24px"}
            {__("Groups")}
          </a>
        </li>
      {/if}

      {if $system['events_enabled']}
        <li {if $page == "events"}class="active" {/if}>
          <a href="{$system['system_url']}/events">
            {include file='__svg_icons.tpl' icon="events" class="mr10" width="24px" height="24px"}
            {__("Events")}
          </a>
        </li>
      {/if}

      {if $system['blogs_enabled']}
        <li {if $page == "blogs"}class="active" {/if}>
          <a href="{$system['system_url']}/blogs">
            {include file='__svg_icons.tpl' icon="blogs" class="mr10" width="24px" height="24px"}
            {__("Blogs")}
          </a>
        </li>
      {/if}

      {if $system['market_enabled']}
        <li>
          <a href="{$system['system_url']}/market">
            {include file='__svg_icons.tpl' icon="market" class="mr10" width="24px" height="24px"}
            {__("Marketplace")}
          </a>
        </li>
      {/if}

      {if $system['funding_enabled']}
        <li {if $page == "funding"}class="active" {/if}>
          <a href="{$system['system_url']}/funding">
            {include file='__svg_icons.tpl' icon="funding" class="mr10" width="24px" height="24px"}
            {__("Funding")}
          </a>
        </li>
      {/if}

      {if $system['pages_enabled'] && $system['offers_enabled']}
        <li {if $page == "offers"}class="active" {/if}>
          <a href="{$system['system_url']}/offers">
            {include file='__svg_icons.tpl' icon="offers" class="mr10" width="24px" height="24px"}
            {__("Offers")}
          </a>
        </li>
      {/if}

      {if $system['pages_enabled'] && $system['jobs_enabled']}
        <li {if $page == "jobs"}class="active" {/if}>
          <a href="{$system['system_url']}/jobs">
            {include file='__svg_icons.tpl' icon="jobs" class="mr10" width="24px" height="24px"}
            {__("Jobs")}
          </a>
        </li>
      {/if}

      {if $system['forums_enabled']}
        <li {if $page == "forums"}class="active" {/if}>
          <a href="{$system['system_url']}/forums">
            {include file='__svg_icons.tpl' icon="forums" class="mr10" width="24px" height="24px"}
            {__("Forums")}
          </a>
        </li>
      {/if}

      {if $system['movies_enabled']}
        <li {if $page == "movies"}class="active" {/if}>
          <a href="{$system['system_url']}/movies">
            {include file='__svg_icons.tpl' icon="movies" class="mr10" width="24px" height="24px"}
            {__("Movies")}
          </a>
        </li>
      {/if}

      {if $system['games_enabled']}
        <li {if $page == "games"}class="active" {/if}>
          <a href="{$system['system_url']}/games">
            {include file='__svg_icons.tpl' icon="games" class="mr10" width="24px" height="24px"}
            {__("Games")}
          </a>
        </li>
      {/if}

      {if $system['developers_apps_enabled'] || $system['developers_share_enabled']}
        <li {if $page == "developers"}class="active" {/if}>
          <a href="{$system['system_url']}/developers{if !$system['developers_apps_enabled']}/share{/if}">
            {include file='__svg_icons.tpl' icon="developers" class="mr10" width="24px" height="24px"}
            {__("Developers")}
          </a>
        </li>
      {/if}
      <!-- explore -->
    </ul>
  </div>
</div>