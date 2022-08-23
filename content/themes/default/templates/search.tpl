{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_file_searching_duff.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="inner">
    <h2>{__("Search")}</h2>
    <p class="text-xlg">{__("Discover new people, create new connections and make new friends")}</p>
  </div>
</div>
<!-- page header -->

<!-- page content -->
<div class="container offcanvas" style="margin-top: -45px;">
  <div class="row">

    <!-- side panel -->
    <div class="col-12 d-block d-sm-none offcanvas-sidebar mt30">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-12 offcanvas-mainbar">
      <!-- search form -->
      <div class="card">
        <div class="card-body">
          <form class="js_search-form">
            <div class="form-group mb0">
              <div class="input-group">
                <input type="text" class="form-control" name="query" placeholder='{__("Search")}'>
                <div class="input-group-append">
                  <button type="submit" name="submit" class="btn btn-danger plr30"><i class="fas fa-search mr10"></i>{__("Search")}</button>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
      <!-- search form -->

      <div class="row">
        <!-- left panel -->
        <div class="col-lg-8">
          <!-- panel nav -->
          <ul class="nav nav-pills nav-fill nav-search mb10">
            <li class="nav-item">
              <a class="nav-link rounded-pill {if $tab == "" || $tab == "posts"}active{/if}" href="{$system['system_url']}/search/{if $hashtag}hashtag/{/if}{$query}/posts">
                <i class="fa fa-newspaper mr5"></i><strong>{__("Posts")}</strong>
              </a>
            </li>
            {if $system['blogs_enabled']}
              <li class="nav-item">
                <a class="nav-link rounded-pill {if $tab == "articles"}active{/if}" href="{$system['system_url']}/search/{if $hashtag}hashtag/{/if}{$query}/articles">
                  <i class="fab fa-blogger-b mr5"></i><strong>{__("Articles")}</strong>
                </a>
              </li>
            {/if}
            <li class="nav-item">
              <a class="nav-link rounded-pill {if $tab == "users"}active{/if}" href="{$system['system_url']}/search/{$query}/users">
                <i class="fa fa-user mr5"></i><strong>{__("Users")}</strong>
              </a>
            </li>
            {if $system['pages_enabled']}
              <li class="nav-item">
                <a class="nav-link rounded-pill {if $tab == "pages"}active{/if}" href="{$system['system_url']}/search/{$query}/pages">
                  <i class="fa fa-flag mr5"></i><strong>{__("Pages")}</strong>
                </a>
              </li>
            {/if}
            {if $system['groups_enabled']}
              <li class="nav-item">
                <a class="nav-link rounded-pill {if $tab == "groups"}active{/if}" href="{$system['system_url']}/search/{$query}/groups">
                  <i class="fa fa-users mr5"></i><strong>{__("Groups")}</strong>
                </a>
              </li>
            {/if}
            {if $system['events_enabled']}
              <li class="nav-item">
                <a class="nav-link rounded-pill {if $tab == "events"}active{/if}" href="{$system['system_url']}/search/{$query}/events">
                  <i class="fa fa-calendar mr5"></i><strong>{__("Events")}</strong>
                </a>
              </li>
            {/if}
          </ul>
          <!-- panel nav -->

          <div class="tab-content">

            <div class="tab-pane active">
              {if $results}
                <ul>
                  {if $tab == "" || $tab == "posts"}
                    <!-- posts -->
                    {foreach $results as $post}
                      {include file='__feeds_post.tpl'}
                    {/foreach}
                    <!-- posts -->
                  {elseif $tab == "articles"}
                    <!-- articles -->
                    {foreach $results as $post}
                      {include file='__feeds_post.tpl'}
                    {/foreach}
                    <!-- articles -->
                  {elseif $tab == "users"}
                    <!-- users -->
                    {foreach $results as $_user}
                      {include file='__feeds_user.tpl' _tpl="list" _connection=$_user['connection']}
                    {/foreach}
                    <!-- users -->
                  {elseif $tab == "pages"}
                    <!-- pages -->
                    {foreach $results as $_page}
                      {include file='__feeds_page.tpl' _tpl="list"}
                    {/foreach}
                    <!-- pages -->
                  {elseif $tab == "groups"}
                    <!-- groups -->
                    {foreach $results as $_group}
                      {include file='__feeds_group.tpl' _tpl="list"}
                    {/foreach}
                    <!-- groups -->
                  {elseif $tab == "events"}
                    <!-- events -->
                    {foreach $results as $_event}
                      {include file='__feeds_event.tpl' _tpl="list"}
                    {/foreach}
                    <!-- events -->
                  {/if}
                </ul>

                {if count($results) >= $system['search_results']}
                  <!-- see-more -->
                  <div class="alert alert-post see-more mb20 js_see-more js_see-more-infinite" data-get="search_{$tab}" data-filter="{$query}">
                    <span>{__("More Results")}</span>
                    <div class="loader loader_small x-hidden"></div>
                  </div>
                  <!-- see-more -->
                {/if}
              {else}
                {include file='_no_data.tpl'}
              {/if}
            </div>

          </div>
        </div>
        <!-- left panel -->

        <!-- right panel -->
        <div class="col-lg-4">
          {include file='_ads_campaigns.tpl'}
          {include file='_ads.tpl'}
          {include file='_widget.tpl'}
        </div>
        <!-- right panel -->
      </div>
    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}