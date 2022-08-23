{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page content -->
<div class="container mt20 offcanvas">
  <div class="row">

    <!-- side panel -->
    <div class="col-12 d-block d-md-none offcanvas-sidebar mt20">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-12 offcanvas-mainbar">
      <div class="row">
        <!-- left panel -->
        <div class="col-md-8 col-lg-6 offset-lg-3">
          {include file='__feeds_post.tpl' standalone=true}
        </div>
        <!-- left panel -->

        <!-- right panel -->
        <div class="col-md-4 col-lg-3">
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