{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container mt20 offcanvas">
  <div class="row">

    <!-- side panel -->
    <div class="col-md-4 col-lg-3 offcanvas-sidebar js_sticky-sidebar">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-md-8 col-lg-9 offcanvas-mainbar">

      <!-- tabs -->
      <div class="content-tabs rounded-sm shadow-sm clearfix">
        <ul>
          <li {if $view == ""}class="active" {/if}>
            <a href="{$system['system_url']}/pages">{__("Discover")}</a>
          </li>
          {if $user->_logged_in}
            <li {if $view == "liked"}class="active" {/if}>
              <a href="{$system['system_url']}/pages/liked">{__("Liked Pages")}</a>
            </li>
            <li {if $view == "manage"}class="active" {/if}>
              <a href="{$system['system_url']}/pages/manage">{__("My Pages")}</a>
            </li>
          {/if}
        </ul>
        {if $user->_data['can_create_pages']}
          <div class="mt10 float-right">
            <button class="btn btn-sm btn-success d-none d-lg-block" data-toggle="modal" data-url="pages_groups_events/add.php?type=page">
              <i class="fa fa-plus-circle mr5"></i>{__("Create Page")}
            </button>
            <button class="btn btn-sm btn-icon btn-success d-block d-lg-none" data-toggle="modal" data-url="pages_groups_events/add.php?type=page">
              <i class="fa fa-plus-circle"></i>
            </button>
          </div>
        {/if}
      </div>
      <!-- tabs -->

      <!-- content -->
      <div>
        {if $pages}
          <ul class="row">
            {foreach $pages as $_page}
              {include file='__feeds_page.tpl' _tpl='box'}
            {/foreach}
          </ul>

          <!-- see-more -->
          {if count($pages) >= $system['pages_results']}
            <div class="alert alert-post see-more js_see-more" data-get="{$get}" data-uid="{$user->_data['user_id']}">
              <span>{__("See More")}</span>
              <div class="loader loader_small x-hidden"></div>
            </div>
          {/if}
          <!-- see-more -->
        {else}
          {include file='_no_data.tpl'}
        {/if}
      </div>
      <!-- content -->

    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}