<div class="modal-header">
  <h6 class="modal-title">
    <i class="fa fa-flag mr5"></i>{__("Report")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<form class="js_ajax-forms" data-url="data/report.php?do=submit&id={$id}&handle={$handle}">
  <div class="modal-body">

    <div class="form-group">
      <label class="form-control-label">{__("Why you want to report this?")}</label>
      <select class="form-control" name="category" id="category">
        {foreach $categories as $category}
          {include file='__categories.recursive_options.tpl'}
        {/foreach}
      </select>
    </div>

    <div class="row">
      <div class="col-md-12">
        <div class="form-group">
          <label class="form-control-label">{__("Reason")}</label>
          <textarea name="reason" rows="3" dir="auto" class="form-control"></textarea>
        </div>
      </div>
    </div>

    <!-- error -->
    <div class="alert alert-danger mb0 x-hidden"></div>
    <!-- error -->
  </div>
  <div class="modal-footer">
    <button type="submit" class="btn btn-primary">{__("Report")}</button>
  </div>
</form>