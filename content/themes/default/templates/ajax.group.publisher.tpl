<div class="modal-header">
  <h6 class="modal-title">
    <i class="fa fa-users mr10" style="color: #2b53a4;"></i>{__("Create New Group")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<form class="js_ajax-forms" data-url="pages_groups_events/create.php?type=group&do=create">
  <div class="modal-body">
    <div class="form-group">
      <label class="form-control-label" for="title">{__("Name Your Group")}</label>
      <input type="text" class="form-control" name="title" id="title">
    </div>
    <div class="form-group">
      <label class="form-control-label" for="username">{__("Group Username")}</label>
      <div class="input-group">
        <div class="input-group-prepend">
          <span class="input-group-text d-none d-sm-block">{$system['system_url']}/groups/</span>
        </div>
        <input type="text" class="form-control" name="username" id="username">
      </div>
      <span class="form-text">
        {__("Can only contain alphanumeric characters (A–Z, 0–9) and periods ('.')")}
      </span>
    </div>
    <div class="form-group">
      <label class="form-control-label" for="privacy">{__("Select Privacy")}</label>
      <select class="form-control selectpicker" name="privacy">
        <option value="public" data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-2x'></i></div><div class='text'><b>{__("Public Group")}</b><span class='d-none d-md-inline'><br>{__("Anyone can see the group, its members and their posts")}.</span>
                </div></div>">{__("Public Group")}</option>
        <option value="closed" data-content="<div class='option'><div class='icon'><i class='fa fa-unlock-alt fa-2x'></i></div><div class='text'><b>{__("Closed Group")}</b><span class='d-none d-md-inline'><br>{__("Only members can see posts")}.</span>
                </div></div>">{__("Closed Group")}</option>
        <option value="secret" data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-2x'></i></div><div class='text'><b>{__("Secret Group")}</b><span class='d-none d-md-inline'><br>{__("Only members can find the group and see posts")}.</span>
                </div></div>">{__("Secret Group")}</option>
      </select>
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
      <textarea class="form-control" name="description"></textarea>
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