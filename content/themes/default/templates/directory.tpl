{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_bookmarks_r6up.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="inner">
    <h2>{__("Directory")}</h2>
    <p class="text-xlg">{__($system['system_description_directory'])}</p>
  </div>
</div>
<!-- page header -->

<!-- page content -->
{if $view == ""}

  <div class="container offcanvas" style="margin-top: -25px;">
    <div class="row">
      <!-- side panel -->
      <div class="col-12 d-block d-md-none offcanvas-sidebar mt20">
        {include file='_sidebar.tpl'}
      </div>
      <!-- side panel -->

      <!-- content panel -->
      <div class="col-12 offcanvas-mainbar">
        <div class="card border-0 shadow">
          <div class="card-body page-content pb25">
            <div class="row">
              <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                <a href="{$system['system_url']}/directory/users" class="directory-card">
                  {include file='__svg_icons.tpl' icon="find_people" width="120px" height="120px"}
                  <h5 class="title">{__("Users")}</h5>
                  <p>
                    {__("Help friends know you better and show them what you have in common")}
                  </p>
                </a>
              </div>
              <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                <a href="{$system['system_url']}/directory/posts" class="directory-card">
                  {include file='__svg_icons.tpl' icon="newsfeed" width="120px" height="120px"}
                  <h5 class="title">{__("Posts")}</h5>
                  <p>
                    {__("See what everyone’s up to and what’s on their minds")}
                  </p>
                </a>
              </div>
              {if $system['pages_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/directory/pages" class="directory-card">
                    {include file='__svg_icons.tpl' icon="pages" width="120px" height="120px"}
                    <h5 class="title">{__("Pages")}</h5>
                    <p>
                      {__("Never miss a thing out! Keep in touch with your fans and customers")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['groups_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/directory/groups" class="directory-card">
                    {include file='__svg_icons.tpl' icon="groups" width="120px" height="120px"}
                    <h5 class="title">{__("Groups")}</h5>
                    <p>
                      {__("Communicate and collaborate with the people who share your interests")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['events_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/directory/events" class="directory-card">
                    {include file='__svg_icons.tpl' icon="events" width="120px" height="120px"}
                    <h5 class="title">{__("Events")}</h5>
                    <p>
                      {__("Members can organize community events for online and offline doings")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['blogs_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/blogs" class="directory-card">
                    {include file='__svg_icons.tpl' icon="blogs" width="120px" height="120px"}
                    <h5 class="title">{__("Blogs")}</h5>
                    <p>
                      {__("Sharing thoughts, ideas and creating amazing contents")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['market_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/market" class="directory-card">
                    {include file='__svg_icons.tpl' icon="market" width="120px" height="120px"}
                    <h5 class="title">{__("Marketplace")}</h5>
                    <p>
                      {__("Trusted community marketplace wherein members can post and browse items")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['funding_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/funding" class="directory-card">
                    {include file='__svg_icons.tpl' icon="funding" width="120px" height="120px"}
                    <h5 class="title">{__("Funding")}</h5>
                    <p>
                      {__("Fundraisers make it easy to support friends, family and the causes that are important to you")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['pages_enabled'] && $system['offers_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/offers" class="directory-card">
                    {include file='__svg_icons.tpl' icon="offers" width="120px" height="120px"}
                    <h5 class="title">{__("Offers")}</h5>
                    <p>
                      {__("Find the best offers that you can buy")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['pages_enabled'] && $system['jobs_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/jobs" class="directory-card">
                    {include file='__svg_icons.tpl' icon="jobs" width="120px" height="120px"}
                    <h5 class="title">{__("Jobs")}</h5>
                    <p>
                      {__("Seeking for a job, You can find theme here")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['forums_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/forums" class="directory-card">
                    {include file='__svg_icons.tpl' icon="forums" width="120px" height="120px"}
                    <h5 class="title">{__("Forums")}</h5>
                    <p>
                      {__("Forum is an old­school framework for online community")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['movies_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/movies" class="directory-card">
                    {include file='__svg_icons.tpl' icon="movies" width="120px" height="120px"}
                    <h5 class="title">{__("Movies")}</h5>
                    <p>
                      {__("Watching movies always fun, Watch with the people who share your interests")}
                    </p>
                  </a>
                </div>
              {/if}
              {if $system['games_enabled']}
                <div class="col-sm-6 col-md-6 col-lg-4 mb25">
                  <a href="{$system['system_url']}/directory/games" class="directory-card">
                    {include file='__svg_icons.tpl' icon="games" width="120px" height="120px"}
                    <h5 class="title">{__("Games")}</h5>
                    <p>
                      {__("Playing games always fun, Play with the people who share your interests")}
                    </p>
                  </a>
                </div>
              {/if}
            </div>
          </div>
        </div>
      </div>
      <!-- content panel -->
    </div>
  </div>

{else}

  <div class="container mt20 offcanvas">
    <div class="row">

      <!-- left panel -->
      <div class="col-md-4 col-lg-3 offcanvas-sidebar">
        <div class="card">
          <div class="card-body with-nav">
            <ul class="side-nav">
              <li {if $view == "users"}class="active" {/if}>
                <a href="{$system['system_url']}/directory/users">
                  {include file='__svg_icons.tpl' icon="find_people" class="mr10" width="24px" height="24px"}
                  {__("Users")}
                </a>
              </li>
              <li {if $view == "posts"}class="active" {/if}>
                <a href="{$system['system_url']}/directory/posts">
                  {include file='__svg_icons.tpl' icon="newsfeed" class="mr10" width="24px" height="24px"}
                  {__("Posts")}</a>
              </li>
              {if $system['pages_enabled']}
                <li {if $view == "pages"}class="active" {/if}>
                  <a href="{$system['system_url']}/directory/pages">
                    {include file='__svg_icons.tpl' icon="pages" class="mr10" width="24px" height="24px"}
                    {__("Pages")}
                  </a>
                </li>
              {/if}
              {if $system['groups_enabled']}
                <li {if $view == "groups"}class="active" {/if}>
                  <a href="{$system['system_url']}/directory/groups">
                    {include file='__svg_icons.tpl' icon="groups" class="mr10" width="24px" height="24px"}
                    {__("Groups")}
                  </a>
                </li>
              {/if}
              {if $system['events_enabled']}
                <li {if $view == "events"}class="active" {/if}>
                  <a href="{$system['system_url']}/directory/events">
                    {include file='__svg_icons.tpl' icon="events" class="mr10" width="24px" height="24px"}
                    {__("Events")}
                  </a>
                </li>
              {/if}
              {if $system['blogs_enabled']}
                <li>
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
                <li>
                  <a href="{$system['system_url']}/funding">
                    {include file='__svg_icons.tpl' icon="funding" class="mr10" width="24px" height="24px"}
                    {__("Funding")}
                  </a>
                </li>
              {/if}
              {if $system['pages_enabled'] && $system['offers_enabled']}
                <li>
                  <a href="{$system['system_url']}/offers">
                    {include file='__svg_icons.tpl' icon="offers" class="mr10" width="24px" height="24px"}
                    {__("Offers")}
                  </a>
                </li>
              {/if}
              {if $system['pages_enabled'] && $system['jobs_enabled']}
                <li>
                  <a href="{$system['system_url']}/jobs">
                    {include file='__svg_icons.tpl' icon="jobs" class="mr10" width="24px" height="24px"}
                    {__("Jobs")}
                  </a>
                </li>
              {/if}
              {if $system['forums_enabled']}
                <li>
                  <a href="{$system['system_url']}/forums">
                    {include file='__svg_icons.tpl' icon="forums" class="mr10" width="24px" height="24px"}
                    {__("Forums")}
                  </a>
                </li>
              {/if}
              {if $system['movies_enabled']}
                <li>
                  <a href="{$system['system_url']}/movies">
                    {include file='__svg_icons.tpl' icon="movies" class="mr10" width="24px" height="24px"}
                    {__("Movies")}
                  </a>
                </li>
              {/if}
              {if $system['games_enabled']}
                <li {if $view == "games"}class="active" {/if}>
                  <a href="{$system['system_url']}/directory/games">
                    {include file='__svg_icons.tpl' icon="games" class="mr10" width="24px" height="24px"}
                    {__("Games")}
                  </a>
                </li>
              {/if}
            </ul>
          </div>
        </div>
      </div>
      <!-- left panel -->

      <!-- right panel -->
      <div class="col-md-8 col-lg-9 offcanvas-mainbar">
        <div class="row">
          <!-- center panel -->
          <div class="col-lg-8">
            {if $view == "users"}
              {if $rows}
                <ul>
                  {foreach $rows as $_user}
                    {include file='__feeds_user.tpl' _tpl="list" _connection=$_user["connection"]}
                  {/foreach}
                </ul>
                {$pager}
              {else}
                {include file='_no_data.tpl'}
              {/if}

            {elseif $view == "posts"}
              {if $rows}
                <ul>
                  {foreach $rows as $post}
                    {include file='__feeds_post.tpl'}
                  {/foreach}
                </ul>
                {$pager}
              {else}
                {include file='_no_data.tpl'}
              {/if}

            {elseif $view == "pages"}
              {if $rows}
                <ul>
                  {foreach $rows as $_page}
                    {include file='__feeds_page.tpl' _tpl="list"}
                  {/foreach}
                </ul>
                {$pager}
              {else}
                {include file='_no_data.tpl'}
              {/if}

            {elseif $view == "groups"}
              {if $rows}
                <ul>
                  {foreach $rows as $_group}
                    {include file='__feeds_group.tpl' _tpl="list"}
                  {/foreach}
                </ul>
                {$pager}
              {else}
                {include file='_no_data.tpl'}
              {/if}

            {elseif $view == "events"}
              {if $rows}
                <ul>
                  {foreach $rows as $_event}
                    {include file='__feeds_event.tpl' _tpl="list"}
                  {/foreach}
                </ul>
                {$pager}
              {else}
                {include file='_no_data.tpl'}
              {/if}

            {elseif $view == "games"}
              {if $rows}
                <ul>
                  {foreach $rows as $_game}
                    {include file='__feeds_game.tpl' _tpl="list"}
                  {/foreach}
                </ul>
                {$pager}
              {else}
                {include file='_no_data.tpl'}
              {/if}

            {/if}
          </div>
          <!-- center panel -->

          <!-- right panel -->
          <div class="col-lg-4">
            {include file='_ads_campaigns.tpl'}
            {include file='_ads.tpl'}
            {include file='_widget.tpl'}
          </div>
          <!-- right panel -->
        </div>
      </div>
      <!-- right panel -->

    </div>
  </div>

{/if}
<!-- page content -->

{include file='_footer.tpl'}