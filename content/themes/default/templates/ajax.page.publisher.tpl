<div class="modal-header">
  <h6 class="modal-title">
    <i class="fa fa-flag mr10" style="color: #2196f3;"></i>{__("Create New Page")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<form class="js_ajax-forms" data-url="pages_groups_events/create.php?type=page&do=create">
  <div class="modal-body">
    <div class="form-group">
      <label class="form-control-label" for="title">{__("Name Your Page")}</label>
      <input type="text" class="form-control" name="title" id="title">
    </div>
    <div class="form-group">
      <label class="form-control-label" for="username">{__("Page Username")}</label>
      <div class="input-group">
        <div class="input-group-prepend">
          <span class="input-group-text d-none d-sm-block">{$system['system_url']}/pages/</span>
        </div>
        <input type="text" class="form-control" name="username" id="username">
      </div>
      <span class="form-text">
        {__("Can only contain alphanumeric characters (A–Z, 0–9) and periods ('.')")}
      </span>
    </div>
    <div class="form-group">
      <label class="form-control-label" for="category">{__("Category")}</label>
      <select class="form-control" name="category" id="category">
        <option>{__("Select Category")}</option>
        {foreach $categories as $category}
          {include file='__categories.recursive_options.tpl'}
        {/foreach}
      </select>
    </div>
    <div class="form-group">
      <label class="form-control-label" for="description">{__("About")}</label>
      <textarea class="form-control" name="description" name="description"></textarea>
    </div>
    <!-- custom fields -->
    {if $custom_fields}
      {include file='__custom_fields.tpl' _custom_fields=$custom_fields _registration=true}
    {/if}
    <!-- custom fields -->
    <!-- error -->
    <div class="alert alert-danger mb0 mt10 x-hidden"></div>
    <!-- error -->
  </div>
  <div class="modal-footer">
    <button type="button" class="btn btn-light" data-dismiss="modal">{__("Cancel")}</button>
    <button type="submit" class="btn btn-primary">{__("Create")}</button>
  </div>
</form>