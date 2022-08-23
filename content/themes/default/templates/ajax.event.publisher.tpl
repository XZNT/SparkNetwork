<div class="modal-header">
  <h6 class="modal-title">
    <i class="fa fa-calendar-plus mr10" style="color: #f79f58;"></i>{__("Create New Event")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<form class="js_ajax-forms" data-url="pages_groups_events/create.php?type=event&do=create">
  <div class="modal-body">
    <div class="form-group">
      <label class="form-control-label" for="title">{__("Name Your Event")}</label>
      <input type="text" class="form-control" name="title" id="title">
    </div>
    <div class="form-group">
      <label class="form-control-label" for="location">{__("Location")}</label>
      <input type="text" class="form-control js_geocomplete" name="location" id="location">
    </div>
    <div class="form-group">
      <label class="form-control-label">{__("Start Date")}</label>
      <div class="input-group date js_datetimepicker" id="start_date" data-target-input="nearest">
        <input type='text' class="form-control datetimepicker-input" data-target="#start_date" name="start_date" />
        <div class="input-group-append" data-target="#start_date" data-toggle="datetimepicker">
          <span class="input-group-text"><i class="fa fa-calendar"></i></span>
        </div>
      </div>
    </div>
    <div class="form-group">
      <label class="form-control-label">{__("End Date")}</label>
      <div class="input-group date js_datetimepicker" id="end_date" data-target-input="nearest">
        <input type='text' class="form-control datetimepicker-input" data-target="#end_date" name="end_date" />
        <div class="input-group-append" data-target="#end_date" data-toggle="datetimepicker">
          <span class="input-group-text"><i class="fa fa-calendar"></i></span>
        </div>
      </div>
    </div>
    <div class="form-group">
      <label class="form-control-label" for="privacy">{__("Select Privacy")}</label>
      <select class="form-control selectpicker" name="privacy">
        <option value="public" data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-2x'></i></div><div class='text'><b>{__("Public Event")}</b><span class='d-none d-md-inline'><br>{__("Anyone can see the event, its users and posts")}.</span>
                </div></div>">{__("Public Event")}</option>
        <option value="closed" data-content="<div class='option'><div class='icon'><i class='fa fa-unlock-alt fa-2x'></i></div><div class='text'><b>{__("Closed Event")}</b><span class='d-none d-md-inline'><br>{__("Only event users can see posts")}.</span>
                </div></div>">{__("Closed Event")}</option>
        <option value="secret" data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-2x'></i></div><div class='text'><b>{__("Secret Event")}</b><span class='d-none d-md-inline'><br>{__("Only invited users and event users can find the event")}.</span>
                </div></div>">{__("Secret Event")}</option>
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