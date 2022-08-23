<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == ""}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/genders/add" class="btn btn-sm btn-primary">
          <i class="fa fa-plus mr5"></i>{__("Add New Gender")}
        </a>
      </div>
    {elseif $sub_view == "add" || $sub_view == "edit"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/genders" class="btn btn-sm btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {/if}
    <i class="fa fa-venus-mars mr10"></i>{__("Genders")}
    {if $sub_view == "edit"} &rsaquo; {$data['name']}{/if}
    {if $sub_view == "add"} &rsaquo; {__("Add New Gender")}{/if}
  </div>

  {if $sub_view == ""}

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Name")}</th>
              <th>{__("Order")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td>{$row['gender_id']}</td>
                <td>{$row['gender_name']}</td>
                <td>{$row['gender_order']}</td>
                <td>
                  <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' href="{$system['system_url']}/{$control_panel['url']}/genders/edit/{$row['gender_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                    <i class="fa fa-pencil-alt"></i>
                  </a>
                  <button data-toggle="tooltip" data-placement="top" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="gender" data-id="{$row['gender_id']}">
                    <i class="fa fa-trash-alt"></i>
                  </button>
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    </div>

  {elseif $sub_view == "edit"}

    <form class="js_ajax-forms" data-url="admin/genders.php?do=edit&id={$data['gender_id']}">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="gender_name" value="{$data['gender_name']}">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="gender_order" value="{$data['gender_order']}">
          </div>
        </div>

        <!-- success -->
        <div class="alert alert-success mb0 x-hidden"></div>
        <!-- success -->

        <!-- error -->
        <div class="alert alert-danger mb0 x-hidden"></div>
        <!-- error -->
      </div>
      <div class="card-footer text-right">
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>

  {elseif $sub_view == "add"}

    <form class="js_ajax-forms" data-url="admin/genders.php?do=add">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="gender_name">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="gender_order">
          </div>
        </div>

        <!-- success -->
        <div class="alert alert-success mb0 x-hidden"></div>
        <!-- success -->

        <!-- error -->
        <div class="alert alert-danger mb0 x-hidden"></div>
        <!-- error -->
      </div>
      <div class="card-footer text-right">
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>

  {/if}
</div>