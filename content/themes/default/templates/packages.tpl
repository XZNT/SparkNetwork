{include file='_head.tpl'}
{include file='_header.tpl'}


{if $view == "packages"}

  <!-- page header -->
  <div class="page-header">
    <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_upgrade_06a0.svg">
    <div class="circle-2"></div>
    <div class="circle-3"></div>
    <div class="inner">
      <h2>{__("Pro Packages")}</h2>
      <p class="text-xlg">{__("Choose the Plan That's Right for You")}</p>
    </div>
  </div>
  <!-- page header -->

  <!-- page content -->
  <div class="container offcanvas" style="margin-top: -25px;">
    <div class="row">

      <!-- side panel -->
      <div class="col-12 d-block d-sm-none offcanvas-sidebar mt20">
        {include file='_sidebar.tpl'}
      </div>
      <!-- side panel -->

      <!-- content panel -->
      <div class="col-12 offcanvas-mainbar">
        <div class="card">
          <div class="card-body">
            <div class="row justify-content-md-center">
              {foreach $packages as $package}
                <!-- package -->
                <div class="col-md-6 col-lg-4 col-xl-{if $packages_count >= 4}3{elseif $packages_count == 3}4{elseif $packages_count <= 2}6{/if} text-center">
                  <div class="card card-pricing shadow-sm">
                    <div class="card-header bg-transparent">
                      <h3>{__($package['name'])}</h3>
                      <img src="{$package['icon']}" style="max-width: 48px;">
                    </div>
                    <div class="card-body text-center">
                      <h2 class="price" style="color: {$package['color']}">
                        {if $package['price'] == 0}
                          {__("Free")}
                        {else}
                          {print_money($package['price'])}
                        {/if}
                      </h2>
                      <div>
                        {if $package['period'] == "life"}
                          {__("Life Time")}
                        {else}
                          {__("for")}
                          {if $package['period_num'] != '1'}{$package['period_num']}{/if} {__($package['period']|ucfirst)}
                        {/if}
                      </div>
                    </div>
                    <ul class="list-group list-group-flush text-center">
                      <li class="list-group-item"><i class="fa fa-check green mr10"></i>{__("Featured member")}</li>
                      <li class="list-group-item">
                        {if $package['verification_badge_enabled']}
                          <i class="fa fa-check green mr10"></i>
                        {else}
                          <i class="fa fa-times red mr10"></i>
                        {/if}
                        {__("Verified badge")}
                      </li>
                      <li class="list-group-item">
                        {if !$package['boost_posts_enabled']}
                          <i class="fa fa-times red mr10"></i>{__("Posts promotion")}
                        {else}
                          <i class="fa fa-check green mr10"></i>{__("Boost up to")} {$package['boost_posts']} {__("Posts")}
                        {/if}
                      </li>
                      <li class="list-group-item">
                        {if !$package['boost_pages_enabled']}
                          <i class="fa fa-times red mr10"></i>{__("Pages promotion")}
                        {else}
                          <i class="fa fa-check green mr10"></i>{__("Boost up to")} {$package['boost_pages']} {__("Pages")}
                        {/if}
                      </li>
                      {if $package['custom_description']}
                        <li class="list-group-item">
                          {__($package['custom_description'])|nl2br}
                        </li>
                      {/if}
                    </ul>
                    <div class="card-footer bg-transparent">
                      {if $user->_logged_in}
                        {if $package['price'] == 0}
                          <button class="btn btn-block rounded-pill btn-danger js_try-package" data-id='{$package["package_id"]}'>
                            {__("Try Now")}
                          </button>
                        {else}
                          <button class="btn btn-block rounded-pill btn-danger" data-toggle="modal" data-url="#payment" data-options='{literal}{{/literal}"handle": "packages", "id": {$package["package_id"]}, "price": "{$package["price"]}", "name": "{$package["name"]}", "img": "{$package["icon"]}"{literal}}{/literal}'>
                            {if !$user->_data['user_subscribed']}
                              {__("Buy Now")}
                            {else}
                              {__("Upgrade Now")}
                            {/if}
                          </button>
                        {/if}
                      {else}
                        <a class="btn btn-block rounded-pill btn-danger" href="{$system['system_url']}/signin">
                          {__("Buy Now")}
                        </a>
                      {/if}
                    </div>
                  </div>
                </div>
                <!-- /package -->
              {/foreach}
            </div>
          </div>
        </div>
      </div>
      <!-- content panel -->

    </div>
  </div>
  <!-- page content -->

{elseif $view == "upgraded"}

  <!-- page content -->
  <div class="container mt20 offcanvas">
    <div class="row">

      <!-- side panel -->
      <div class="col-12 d-block d-sm-none offcanvas-sidebar">
        {include file='_sidebar.tpl'}
      </div>
      <!-- side panel -->

      <!-- content panel -->
      <div class="col-12 offcanvas-mainbar">
        <div class="card text-center">
          <div class="card-body">
            <div class="mb20">
              {include file='__svg_icons.tpl' icon="education" width="140px" height="140px"}
            </div>
            <h2>{__("Congratulations")}!</h2>
            <p class="text-xlg mt10">{__("You are now")} <span class="badge badge-danger">{$user->_data['package_name']}</span> {__("member")}</p>
            <a class="btn btn-primary rounded-pill" href="{$system['system_url']}">{__("Start Now")}</a>
          </div>
        </div>
      </div>
      <!-- content panel -->

    </div>
  </div>
  <!-- page content -->

{/if}

{include file='_footer.tpl'}