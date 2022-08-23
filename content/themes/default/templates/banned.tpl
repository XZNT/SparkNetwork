{include file='_head.tpl'}
{include file='_header.tpl'}

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
      <div class="notfound-wrapper">
        <div class="notfound">
          <div class="notfound-circle">
            <i class="far fa-frown"></i>
          </div>
          <h1>{__("Banned!")}</h1>
          <h3>{__($message)}</h3>
          <a class="btn btn-primary rounded-pill mt20" href="{$system['system_url']}">{__("Back to homepage")}</a>
        </div>
      </div>
    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}