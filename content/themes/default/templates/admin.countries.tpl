<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == ""}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/countries/add" class="btn btn-sm btn-primary">
          <i class="fa fa-plus mr5"></i>{__("Add New Country")}
        </a>
      </div>
    {elseif $sub_view == "add" || $sub_view == "edit"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/countries" class="btn btn-sm btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {/if}
    <i class="fa fa-globe mr10"></i>{__("Countries")}
    {if $sub_view == "edit"} &rsaquo; {$data['country_name']}{/if}
    {if $sub_view == "add"} &rsaquo; {__("Add New Country")}{/if}
  </div>

  {if $sub_view == ""}

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Title")}</th>
              <th>{__("Code")}</th>
              <th>{__("Phone")}</th>
              <th>{__("Order")}</th>
              <th>{__("Default")}</th>
              <th>{__("Enabled")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td>{$row['country_id']}</td>
                <td>
                  <a href="{$system['system_url']}/{$control_panel['url']}/countries/edit/{$row['country_id']}">
                    {$row['country_name']}
                  </a>
                </td>
                <td>{$row['country_code']}</td>
                <td>{$row['phone_code']}</td>
                <td>{$row['country_order']}</td>
                <td>
                  {if $row['default']}
                    <span class="badge badge-pill badge-lg badge-success">{__("Yes")}</span>
                  {else}
                    <span class="badge badge-pill badge-lg badge-danger">{__("No")}</span>
                  {/if}
                </td>
                <td>
                  {if $row['enabled']}
                    <span class="badge badge-pill badge-lg badge-success">{__("Yes")}</span>
                  {else}
                    <span class="badge badge-pill badge-lg badge-danger">{__("No")}</span>
                  {/if}
                </td>
                <td>
                  <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' href="{$system['system_url']}/{$control_panel['url']}/countries/edit/{$row['country_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                    <i class="fa fa-pencil-alt"></i>
                  </a>
                  <button data-toggle="tooltip" data-placement="top" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="country" data-id="{$row['country_id']}">
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

    <form class="js_ajax-forms" data-url="admin/countries.php?do=edit&id={$data['country_id']}">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Default")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="default">
              <input type="checkbox" name="default" id="default" {if $data['default']}checked{/if}>
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Make it the default country of the site")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="enabled">
              <input type="checkbox" name="enabled" id="enabled" {if $data['enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Make it enbaled so the user can select it")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Country Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="country_name" value="{$data['country_name']}">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Country Code")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="country_code" value="{$data['country_code']}">
            <span class="form-text">
              {__("Country Code, For Example: us, sa or fr")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Phone Code")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="phone_code" value="{$data['phone_code']}">
            <span class="form-text">
              {__("Phone Code, For Example: +1, +44 or +971")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="country_order" value="{$data['country_order']}">
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

    <form class="js_ajax-forms" data-url="admin/countries.php?do=add">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Default")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="default">
              <input type="checkbox" name="default" id="default">
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Make it the default country of the site")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="enabled">
              <input type="checkbox" name="enabled" id="enabled">
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Make it enbaled so the user can select it")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Country Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="country_name">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Country Code")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="country_code">
            <span class="form-text">
              {__("Country Code, For Example: us, sa or fr")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Phone Code")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="phone_code">
            <span class="form-text">
              {__("Phone Code, For Example: +1, +44 or +971")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="country_order">
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