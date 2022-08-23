{include file='_head.tpl'}
{include file='_header.tpl'}

{if $view == ""}
  <!-- page header -->
  <div class="page-header">
    <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_transfer_money_rywa.svg">
    <div class="circle-2"></div>
    <div class="circle-3"></div>
    <div class="inner">
      <h2>{__("Funding")}</h2>
      <p class="text-xlg">{__($system['system_description_funding'])}</p>
    </div>
  </div>
  <!-- page header -->
{/if}


<!-- page content -->
<div class="container mt20 offcanvas">
  <div class="row">

    <!-- side panel -->
    <div class="col-12 d-block d-md-none offcanvas-sidebar">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-12 offcanvas-mainbar">
      <div class="blogs-wrapper">
        {if $fundings}
          <ul class="row">
            <!-- fundings -->
            {foreach $fundings as $funding}
              {include file='__feeds_funding.tpl' _iteration=$funding@iteration}
            {/foreach}
            <!-- fundings -->
          </ul>

          <!-- see-more -->
          <div class="alert alert-post see-more js_see-more" data-get="fundings">
            <span>{__("More Funding")}</span>
            <div class="loader loader_small x-hidden"></div>
          </div>
          <!-- see-more -->
        {else}
          {include file='_no_data.tpl'}
        {/if}
      </div>
    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}