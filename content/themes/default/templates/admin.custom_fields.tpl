<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == ""}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/custom_fields/add" class="btn btn-sm btn-primary">
          <i class="fa fa-plus mr5"></i>{__("Add New Field")}
        </a>
      </div>
    {else}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/custom_fields" class="btn btn-sm btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {/if}
    <i class="fa fa-bars mr10"></i>{__("Custom Fields")}
    {if $sub_view == "add"} &rsaquo; {__("Add New Field")}{/if}
  </div>

  {if $sub_view == ""}

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Label")}</th>
              <th>{__("For")}</th>
              <th>{__("Type")}</th>
              <th>{__("Place")}</th>
              <th>{__("Order")}</th>
              <th>{__("Mandatory")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td>{$row['field_id']}</td>
                <td>{$row['label']}</td>
                <td>
                  {if $row['field_for'] == "user"}<i class="fa fa-user fa-fw mr5"></i>{__("User")}{/if}
                  {if $row['field_for'] == "page"}<i class="fa fa-flag fa-fw mr5"></i>{__("Page")}{/if}
                  {if $row['field_for'] == "group"}<i class="fa fa-users fa-fw mr5"></i>{__("Group")}{/if}
                  {if $row['field_for'] == "event"}<i class="fa fa-calendar fa-fw mr5"></i>{__("Event")}{/if}
                  {if $row['field_for'] == "product"}<i class="fa fa-cart-plus fa-fw mr5"></i>{__("Product")}{/if}
                  {if $row['field_for'] == "job"}<i class="fa fa-briefcase fa-fw mr5"></i>{__("Job")}{/if}
                  {if $row['field_for'] == "offer"}<i class="fa fa-tag fa-fw mr5"></i>{__("Offer")}{/if}
                </td>
                <td>
                  {if $row['type'] == "textbox"}{__("Text Box")}{/if}
                  {if $row['type'] == "textarea"}{__("Text Area")}{/if}
                  {if $row['type'] == "selectbox"}{__("Select Box")}{/if}
                  {if $row['type'] == "multipleselectbox"}{__("Multiple Select")}{/if}
                </td>
                <td>
                  {if $row['place'] == "basic"}{__("Basic Info")}{/if}
                  {if $row['place'] == "work"}{__("Work Info")}{/if}
                  {if $row['place'] == "location"}{__("Location Info")}{/if}
                  {if $row['place'] == "education"}{__("Education Info")}{/if}
                  {if $row['place'] == "other"}{__("Other Info")}{/if}
                </td>
                <td>{$row['field_order']}</td>
                <td>
                  {if $row['mandatory']}
                    <span class="badge badge-pill badge-lg badge-success">{__("Yes")}</span>
                  {else}
                    <span class="badge badge-pill badge-lg badge-danger">{__("No")}</span>
                  {/if}
                </td>
                <td>
                  <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' href="{$system['system_url']}/{$control_panel['url']}/custom_fields/edit/{$row['field_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                    <i class="fa fa-pencil-alt"></i>
                  </a>
                  <button data-toggle="tooltip" data-placement="top" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="custom_field" data-id="{$row['field_id']}">
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

    <form class="js_ajax-forms" data-url="admin/custom_fields.php?do=edit&id={$data['field_id']}">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Field For")}
          </label>
          <div class="col-md-9">
            <select id="js_field-for" class="form-control" name="field_for">
              <option {if $data['field_for'] == "user"}selected{/if} value="user">{__("User")}</option>
              <option {if $data['field_for'] == "page"}selected{/if} value="page">{__("Page")}</option>
              <option {if $data['field_for'] == "group"}selected{/if} value="group">{__("Group")}</option>
              <option {if $data['field_for'] == "event"}selected{/if} value="event">{__("Event")}</option>
              <option {if $data['field_for'] == "product"}selected{/if} value="product">{__("Product")}</option>
              <option {if $data['field_for'] == "job"}selected{/if} value="job">{__("Job")}</option>
              <option {if $data['field_for'] == "offer"}selected{/if} value="offer">{__("Offer")}</option>
            </select>
            <span class="form-text">
              {__("Where you want to use this field for")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Label")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="label" value="{$data['label']}">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Type")}
          </label>
          <div class="col-md-9">
            <select id="js_field-type" class="form-control" name="type">
              <option {if $data['type'] == "textbox"}selected{/if} value="textbox">{__("Text Box")}</option>
              <option {if $data['type'] == "textarea"}selected{/if} value="textarea">{__("Text Area")}</option>
              <option {if $data['type'] == "selectbox"}selected{/if} value="selectbox">{__("Select Box")}</option>
              <option {if $data['type'] == "multipleselectbox"}selected{/if} value="multipleselectbox">{__("Multiple Select")}</option>
            </select>
          </div>
        </div>

        <div id="js_field-select-options" {if $data['type'] != 'selectbox' &&  $data['type'] != 'multipleselectbox'}class="x-hidden" {/if}>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Select Options")}
            </label>
            <div class="col-md-9">
              <textarea rows="5" class="form-control" name="select_options">{$data['select_options']}</textarea>
              <span class="form-text">
                {__("One option per line")}
              </span>
            </div>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Description")}
          </label>
          <div class="col-md-9">
            <textarea class="form-control" name="description">{$data['description']}</textarea>
            <span class="form-text">
              {__("The description will show under the field")}
            </span>
          </div>
        </div>

        <div id="js_field-place" {if $data['field_for'] != 'user'}class="x-hidden" {/if}>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Place")}
            </label>
            <div class="col-md-9">
              <select class="form-control" name="place">
                <option {if $data['place'] == "basic"}selected{/if} value="basic">{__("Basic Info")}</option>
                <option {if $data['place'] == "work"}selected{/if} value="work">{__("Work Info")}</option>
                <option {if $data['place'] == "location"}selected{/if} value="location">{__("Location Info")}</option>
                <option {if $data['place'] == "education"}selected{/if} value="education">{__("Education Info")}</option>
                <option {if $data['place'] == "other"}selected{/if} value="other">{__("Other Info")}</option>
              </select>
              <span class="form-text">
                {__("Field place in settings page")}
              </span>
            </div>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Value Length")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="length" value="{$data['length']}">
            <span class="form-text">
              {__("Default value is 32, and max value is 1000")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="field_order" value="{$data['field_order']}">
            <span class="form-text">
              {__("The order of this field, custom fields will be displayed in ascending order")}
            </span>
          </div>
        </div>

        <div id="js_field-clickable" {if $data['type'] != 'textbox'}class="x-hidden" {/if}>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Clickable")}
            </label>
            <div class="col-md-9">
              <label class="switch" for="is_link">
                <input type="checkbox" name="is_link" id="is_link" {if $data['is_link']}checked{/if}>
                <span class="slider round"></span>
              </label>
              <span class="form-text">
                {__("Make the value shows as link")}
              </span>
            </div>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Mandatory")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="mandatory">
              <input type="checkbox" name="mandatory" id="mandatory" {if $data['mandatory']}checked{/if}>
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("User must fill the field")}
            </span>
          </div>
        </div>

        <div id="js_field-showin" {if in_array($data['field_for'], ['product', 'job', 'offer'])}class="x-hidden" {/if}>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Show in Registration")}
            </label>
            <div class="col-md-9">
              <label class="switch" for="in_registration">
                <input type="checkbox" name="in_registration" id="in_registration" {if $data['in_registration']}checked{/if}>
                <span class="slider round"></span>
              </label>
              <span class="form-text">
                {__("Show the field in the user registration, create page, create group or create event")}
              </span>
            </div>
          </div>

          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Show in Target Page")}
            </label>
            <div class="col-md-9">
              <label class="switch" for="in_profile">
                <input type="checkbox" name="in_profile" id="in_profile" {if $data['in_profile']}checked{/if}>
                <span class="slider round"></span>
              </label>
              <span class="form-text">
                {__("Show the field in the user's profile, page, group or event")}
              </span>
            </div>
          </div>
        </div>

        <div id="js_field-searchable" {if $data['field_for'] != "user"}class="x-hidden" {/if}>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Show in Search")}
            </label>
            <div class="col-md-9">
              <label class="switch" for="in_search">
                <input type="checkbox" name="in_search" id="in_search" {if $data['in_search']}checked{/if}>
                <span class="slider round"></span>
              </label>
              <span class="form-text">
                {__("Show the field in the find people page")}
              </span>
            </div>
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

    <form class="js_ajax-forms" data-url="admin/custom_fields.php?do=add">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Field For")}
          </label>
          <div class="col-md-9">
            <select id="js_field-for" class="form-control" name="field_for">
              <option value="user">{__("User")}</option>
              <option value="page">{__("Page")}</option>
              <option value="group">{__("Group")}</option>
              <option value="event">{__("Event")}</option>
              <option value="product">{__("Product")}</option>
              <option value="job">{__("Job")}</option>
              <option value="offer">{__("Offer")}</option>
            </select>
            <span class="form-text">
              {__("Where you want to use this field for")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Label")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="label">
            <span class="form-text">
              {__("The label of your custom field, also will be used as a placeholder")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Type")}
          </label>
          <div class="col-md-9">
            <select id="js_field-type" class="form-control" name="type">
              <option value="textbox">{__("Text Box")}</option>
              <option value="textarea">{__("Text Area")}</option>
              <option value="selectbox">{__("Select Box")}</option>
              <option value="multipleselectbox">{__("Multiple Select")}</option>
            </select>
            <span class="form-text">
              {__("The type of your custom field")}
            </span>
          </div>
        </div>

        <div id="js_field-select-options" class="x-hidden">
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Select Options")}
            </label>
            <div class="col-md-9">
              <textarea rows="5" class="form-control" name="select_options"></textarea>
              <span class="form-text">
                {__("One option per line")}
              </span>
            </div>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Description")}
          </label>
          <div class="col-md-9">
            <textarea class="form-control" name="description"></textarea>
            <span class="form-text">
              {__("The description will show under the field")}
            </span>
          </div>
        </div>

        <div id="js_field-place">
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Place")}
            </label>
            <div class="col-md-9">
              <select class="form-control" name="place">
                <option value="basic">{__("Basic Info")}</option>
                <option value="work">{__("Work Info")}</option>
                <option value="location">{__("Location Info")}</option>
                <option value="education">{__("Education Info")}</option>
                <option value="other">{__("Other Info")}</option>
              </select>
              <span class="form-text">
                {__("Field place in settings page")}
              </span>
            </div>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Value Length")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="length" value="32">
            <span class="form-text">
              {__("Default value is 32, and max value is 1000")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="field_order" value="1">
            <span class="form-text">
              {__("The order of this field, custom fields will be displayed in ascending order")}
            </span>
          </div>
        </div>

        <div id="js_field-clickable">
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Clickable")}
            </label>
            <div class="col-md-9">
              <label class="switch" for="is_link">
                <input type="checkbox" name="is_link" id="is_link">
                <span class="slider round"></span>
              </label>
              <span class="form-text">
                {__("Make the value shows as link")}
              </span>
            </div>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Mandatory")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="mandatory">
              <input type="checkbox" name="mandatory" id="mandatory">
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("User must fill the field")}
            </span>
          </div>
        </div>

        <div id="js_field-showin">
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Show in Registration")}
            </label>
            <div class="col-md-9">
              <label class="switch" for="in_registration">
                <input type="checkbox" name="in_registration" id="in_registration">
                <span class="slider round"></span>
              </label>
              <span class="form-text">
                {__("Show the field in the user registration, create page, create group or create event")}
              </span>
            </div>
          </div>

          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Show in Target Page")}
            </label>
            <div class="col-md-9">
              <label class="switch" for="in_profile">
                <input type="checkbox" name="in_profile" id="in_profile">
                <span class="slider round"></span>
              </label>
              <span class="form-text">
                {__("Show the field in the user's profile, page, group or event")}
              </span>
            </div>
          </div>
        </div>

        <div id="js_field-searchable">
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Show in Search")}
            </label>
            <div class="col-md-9">
              <label class="switch" for="in_search">
                <input type="checkbox" name="in_search" id="in_search">
                <span class="slider round"></span>
              </label>
              <span class="form-text">
                {__("Show the field in the find people page")}
              </span>
            </div>
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