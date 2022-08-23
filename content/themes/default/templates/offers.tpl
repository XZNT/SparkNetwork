{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_discount_d4bd.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="container">
    <h2>{__("Offers")}</h2>
    <p class="text-xlg">{__($system['system_description_offers'])}</p>
    <div class="row mt20">
      <div class="col-sm-9 col-lg-6 mx-sm-auto">
        <form class="js_search-form" data-handle="offers">
          <div class="input-group">
            <input type="text" class="form-control" name="query" placeholder='{__("Search for offers")}'>
            <div class="input-group-append">
              <button type="submit" class="btn btn-danger">{__("Search")}</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- page header -->

<!-- page content -->
<div class="container mt20 offcanvas">
  <div class="row">

    <!-- left panel -->
    <div class="col-md-4 col-lg-3 offcanvas-sidebar">
      <!-- categories -->
      <div class="card">
        <div class="card-body with-nav">
          <ul class="side-nav">
            {if $view != "category"}
              <li class="active">
                <a href="{$system['system_url']}/offers">
                  {__("All")}
                </a>
              </li>
            {else}
              <li>
                {if $current_category['parent']}
                  <a href="{$system['system_url']}/offers/category/{$current_category['parent']['category_id']}/{$current_category['parent']['category_url']}">
                    <i class="fas fa-arrow-alt-circle-left mr5"></i>{__($current_category['parent']['category_name'])}
                  </a>
                {else}
                  <a href="{$system['system_url']}/offers">
                    {if $current_category['sub_categories']}<i class="fas fa-arrow-alt-circle-left mr5"></i>{/if}{__("All")}
                  </a>
                {/if}
              </li>
            {/if}
            {foreach $categories as $category}
              <li {if $view == "category" && $current_category['category_id'] == $category['category_id']}class="active" {/if}>
                <a href="{$system['system_url']}/offers/category/{$category['category_id']}/{$category['category_url']}">
                  {__($category['category_name'])}
                  {if $category['sub_categories']}
                    <span class="float-right"><i class="fas fa-angle-right"></i></span>
                  {/if}
                </a>
              </li>
            {/foreach}
          </ul>
        </div>
      </div>
      <!-- categories -->
    </div>
    <!-- left panel -->

    <!-- right panel -->
    <div class="col-md-8 col-lg-9 offcanvas-mainbar">

      {include file='_ads.tpl'}

      {if $view == "search"}
        <div class="bs-callout bs-callout-info mt0">
          <!-- results counter -->
          <span class="badge badge-pill badge-lg badge-light">{$total}</span> {__("results were found for the search for")} "<strong class="text-primary">{htmlentities($query, ENT_QUOTES, 'utf-8')}</strong>"
          <!-- results counter -->
        </div>
      {/if}

      {if $view == "" && $promoted_offers}
        <div class="articles-widget-header">
          <div class="articles-widget-title">{__("Promoted Offers")}</div>
        </div>
        <div class="row mb20">
          {foreach $promoted_offers as $post}
            <div class="col-md-6 col-lg-4">
              <div class="card product boosted">
                <div class="boosted-icon" data-toggle="tooltip" title="{__("Promoted")}">
                  <i class="fa fa-bullhorn"></i>
                </div>
                <div class="product-image">
                  <div class="product-price with-offer">
                    <i class="far fa-calendar-alt mr5"></i>{__("Expires")}: {$post['offer']['end_date']|date_format:"%d/%m/%Y"}
                  </div>
                  <img src="{$system['system_uploads']}/{$post['offer']['thumbnail']}">
                  <div class="product-overlay">
                    <a class="btn btn-sm btn-outline-secondary rounded-pill" href="{$system['system_url']}/posts/{$post['post_id']}">
                      {__("More")}
                    </a>
                  </div>
                </div>
                <div class="product-info">
                  <div class="product-meta title">
                    <a href="{$system['system_url']}/posts/{$post['post_id']}" class="title">{$post['offer']['meta_title']}</a>
                  </div>
                </div>
              </div>
            </div>
          {/foreach}
        </div>
      {/if}

      {if $rows}
        <div class="articles-widget-header clearfix">
          <!-- sort -->
          <div class="float-right">
            <div class="dropdown">
              <button type="button" class="btn btn-sm btn-light dropdown-toggle ml10" data-toggle="dropdown" data-display="static">
                {if !$sort || $sort == "latest"}
                  <i class="fas fa-bars fa-fw"></i> {__("Latest")}
                {elseif $sort == "expire-soon"}
                  <i class="fas fa-sort-amount-down fa-fw"></i> {__("Expire Soon")}
                {elseif $sort == "expire-latest"}
                  <i class="fas fa-sort-amount-down-alt fa-fw"></i> {__("Expire Latest")}
                {/if}
              </button>
              <div class="dropdown-menu dropdown-menu-right">
                <a href="?{if $distance}distance={$distance}&{/if}sort=latest" class="dropdown-item"><i class="fas fa-bars fa-fw mr10"></i>{__("Latest")}</a>
                <a href="?{if $distance}distance={$distance}&{/if}sort=expire-soon" class="dropdown-item"><i class="fas fa-sort-amount-down fa-fw mr10"></i>{__("Expire Soon")}</a>
                <a href="?{if $distance}distance={$distance}&{/if}sort=expire-latest" class="dropdown-item"><i class="fas fa-sort-amount-down-alt fa-fw mr10"></i>{__("Expire Latest")}</a>
              </div>
            </div>
          </div>
          <!-- sort -->
          {if $user->_logged_in && $system['location_finder_enabled']}
            <!-- location filter -->
            <div class="float-right">
              <div class="dropdown">
                <button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" data-display="static">
                  <i class="fa fa-map-marker-alt mr5"></i>{__("Location")}
                </button>
                <div class="dropdown-menu dropdown-menu-right">
                  <form class="ptb15 plr15" method="get" action="?">
                    <div class="form-group">
                      <label class="form-control-label">{__("Distance")}</label>
                      <div>
                        {if $sort}
                          <input type="hidden" name="sort" value="{$sort}">
                        {/if}
                        <input type="range" class="custom-range" min="1" max="5000" name="distance" value="{if $distance}{$distance}{else}5000{/if}" oninput="this.form.distance_value.value=this.value">
                        <div class="input-group">
                          <div class="input-group-prepend">
                            <span class="input-group-text" id="basic-addon1">{if $system['system_distance'] == "mile"}{__("ML")}{else}{__("KM")}{/if}</span>
                          </div>
                          <input disabled type="number" class="form-control" min="1" max="5000" name="distance_value" value="{if $distance}{$distance}{else}5000{/if}" oninput="this.form.distance.value=this.value">
                        </div>
                      </div>
                    </div>
                    <button type="submit" class="btn btn-sm btn-block btn-primary"><i class="fa fa-filter mr5"></i>{__("Filter")}</button>
                  </form>
                </div>
              </div>
            </div>
            <!-- location filter -->
          {/if}
          <div class="articles-widget-title">{__("Offers")}</div>
        </div>

        <div class="row">
          {foreach $rows as $post}
            <div class="col-md-6 col-lg-4">
              <div class="card product">
                <div class="product-image">
                  <div class="product-price with-offer">
                    <i class="far fa-calendar-alt mr5"></i>{__("Expires")}: {$post['offer']['end_date']|date_format:"%d/%m/%Y"}
                  </div>
                  <img src="{$system['system_uploads']}/{$post['offer']['thumbnail']}">
                  <div class="product-overlay">
                    <a class="btn btn-sm btn-outline-secondary rounded-pill" href="{$system['system_url']}/posts/{$post['post_id']}">
                      {__("More")}
                    </a>
                  </div>
                </div>
                <div class="product-info">
                  <div class="product-meta title">
                    <a href="{$system['system_url']}/posts/{$post['post_id']}" class="title">{$post['offer']['meta_title']}</a>
                  </div>
                </div>
              </div>
            </div>
          {/foreach}
        </div>

        {$pager}
      {else}
        {include file='_no_data.tpl'}
      {/if}
    </div>
    <!-- right panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}