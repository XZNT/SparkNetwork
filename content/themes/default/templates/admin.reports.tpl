<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == ""}
      <div class="float-right">
        <button type="button" class="btn btn-sm btn-danger js_admin-deleter" data-handle="reports">
          <i class="fa fa-check"></i><span class="ml5 d-none d-lg-inline-block">{__("Mark All As Safe")}</span>
        </button>
      </div>
    {elseif $sub_view == "categories"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/reports/add_category" class="btn btn-sm btn-primary">
          <i class="fa fa-plus"></i><span class="ml5 d-none d-lg-inline-block">{__("Add New Category")}</span>
        </a>
      </div>
    {elseif $sub_view == "add_category" || $sub_view == "edit_category"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/reports/categories" class="btn btn-sm btn-light">
          <i class="fa fa-arrow-circle-left"></i><span class="ml5 d-none d-lg-inline-block">{__("Go Back")}</span>
        </a>
      </div>
    {/if}

    <i class="fa fa-exclamation-triangle mr10"></i>{__("Reports")}
    {if $sub_view == "categories"} &rsaquo; {__("Categories")}{/if}
    {if $sub_view == "add_category"} &rsaquo; {__("Categories")} &rsaquo; {__("Add New Category")}{/if}
    {if $sub_view == "edit_category"} &rsaquo; {__("Categories")} &rsaquo; {$data['category_name']}{/if}
  </div>
  {if $sub_view == ""}

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Node")}</th>
              <th>{__("Type")}</th>
              <th>{__("Reporter By")}</th>
              <th>{__("Reporter For")}</th>
              <th>{__("Time")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td>{$row['report_id']}</td>
                <td>
                  {if $row['node_type'] == "user"}
                    <a target="_blank" href="{$system['system_url']}/{$row['node']['user_name']}">
                      <img class="tbl-image" src="{$row['node']['user_picture']}">
                      {if $system['show_usernames_enabled']}{$row['node']['user_name']}{else}{$row['node']['user_firstname']} {$row['node']['user_lastname']}{/if}
                    </a>
                  {elseif $row['node_type'] == "page"}
                    <a target="_blank" href="{$system['system_url']}/pages/{$row['node']['page_name']}">
                      <img class="tbl-image" src="{$row['node']['page_picture']}">
                      {$row['node']['page_title']}
                    </a>
                  {elseif $row['node_type'] == "group"}
                    <a target="_blank" href="{$system['system_url']}/groups/{$row['node']['group_name']}">
                      <img class="tbl-image" src="{$row['node']['group_picture']}">
                      {$row['node']['group_title']}
                    </a>
                  {elseif $row['node_type'] == "event"}
                    <a target="_blank" href="{$system['system_url']}/events/{$row['node_id']}">
                      <img class="tbl-image" src="{$row['node']['event_picture']}">
                      {$row['node']['event_title']}
                    </a>
                  {elseif $row['node_type'] == "post"}
                    <a class="btn btn-sm btn-light" href="{$system['system_url']}/posts/{$row['node_id']}" target="_blank">
                      <i class="fa fa-eye mr5"></i>{__("View Post")}
                    </a>
                  {elseif $row['node_type'] == "comment"}
                    <a class="btn btn-sm btn-light" href="{$row['url']}" target="_blank">
                      <i class="fa fa-eye mr5"></i>{__("View Comment")}
                    </a>
                  {elseif $row['node_type'] == "forum_thread"}
                    <a class="btn btn-sm btn-light" href="{$row['url']}" target="_blank">
                      <i class="fa fa-eye mr5"></i>{__("View Thread")}
                    </a>
                  {elseif $row['node_type'] == "forum_reply"}
                    <a class="btn btn-sm btn-light" href="{$row['url']}" target="_blank">
                      <i class="fa fa-eye mr5"></i>{__("View Reply")}
                    </a>
                  {/if}
                </td>
                <td>
                  <span class="badge badge-lg badge-{$row['node']['color']}">{$row['node']['name']|capitalize}</span>
                </td>
                <td>
                  <a target="_blank" href="{$system['system_url']}/{$row['user_name']}">
                    <img class="tbl-image" src="{$row['user_picture']}">
                    {if $system['show_usernames_enabled']}{$row['user_name']}{else}{$row['user_firstname']} {$row['user_lastname']}{/if}
                  </a>
                </td>
                <td>
                  <span class="badge badge-lg badge-light">{$row['category_name']}</span>
                  <p>{$row['reason']}</p>
                </td>
                <td>{$row['time']|date_format:"%e %B %Y"}</td>
                <td>
                  {if $row['node_type'] == "user"}
                    <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' target="_blank" href="{$system['system_url']}/{$control_panel['url']}/users/edit/{$row['node_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                      <i class="fa fa-pencil-alt"></i>
                    </a>
                  {elseif $row['node_type'] == "page"}
                    <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' target="_blank" href="{$system['system_url']}/{$control_panel['url']}/pages/edit_page/{$row['node_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                      <i class="fa fa-pencil-alt"></i>
                    </a>
                  {elseif $row['node_type'] == "group"}
                    <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' target="_blank" href="{$system['system_url']}/{$control_panel['url']}/groups/edit_group/{$row['node_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                      <i class="fa fa-pencil-alt"></i>
                    </a>
                  {elseif $row['node_type'] == "event"}
                    <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' target="_blank" href="{$system['system_url']}/{$control_panel['url']}/events/edit_event/{$row['node_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                      <i class="fa fa-pencil-alt"></i>
                    </a>
                  {elseif $row['node_type'] == "forum_thread"}
                    <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' target="_blank" href="{$system['system_url']}/forums/edit-thread/{$row['node_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                      <i class="fa fa-pencil-alt"></i>
                    </a>
                  {elseif $row['node_type'] == "forum_reply"}
                    <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' target="_blank" href="{$system['system_url']}/forums/edit-reply/{$row['node_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                      <i class="fa fa-pencil-alt"></i>
                    </a>
                  {/if}
                  <button data-toggle="tooltip" data-placement="top" title='{__("Mark as Safe")}' class="btn btn-sm btn-icon btn-rounded btn-success js_admin-deleter" data-handle="report" data-id="{$row['report_id']}">
                    <i class="fa fa-check"></i>
                  </button>
                  <button data-toggle="tooltip" data-placement="top" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="{$row['node_type']}" data-id="{$row['node_id']}" data-node="{$row['report_id']}">
                    <i class="fa fa-trash-alt"></i>
                  </button>
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    </div>

  {elseif $sub_view == "categories"}

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_treegrid">
          <thead>
            <tr>
              <th>{__("Title")}</th>
              <th>{__("Description")}</th>
              <th>{__("Order")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {if $rows}
              {foreach $rows as $row}
                {include file='__categories.recursive_rows.tpl' _url="reports" _handle="report_category"}
              {/foreach}
            {else}
              <tr>
                <td colspan="5" class="text-center">
                  {__("No data to show")}
                </td>
              </tr>
            {/if}
          </tbody>
        </table>
      </div>
    </div>

  {elseif $sub_view == "add_category"}

    <form class="js_ajax-forms" data-url="admin/reports.php?do=add_category">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="category_name">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Description")}
          </label>
          <div class="col-md-9">
            <textarea class="form-control" name="category_description" rows="3"></textarea>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Parent Category")}
          </label>
          <div class="col-md-9">
            <select class="form-control" name="category_parent_id">
              <option value="0">{__("Set as a Partent Category")}</option>
              {foreach $categories as $category}
                {include file='__categories.recursive_options.tpl'}
              {/foreach}
            </select>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="category_order">
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

  {elseif $sub_view == "edit_category"}

    <form class="js_ajax-forms" data-url="admin/reports.php?do=edit_category&id={$data['category_id']}">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="category_name" value="{$data['category_name']}">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Description")}
          </label>
          <div class="col-md-9">
            <textarea class="form-control" name="category_description" rows="3">{$data['category_description']}</textarea>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Parent Category")}
          </label>
          <div class="col-md-9">
            <select class="form-control" name="category_parent_id">
              <option value="0">{__("Set as a Partent Category")}</option>
              {foreach $data["categories"] as $category}
                {include file='__categories.recursive_options.tpl' data_category=$data['category_parent_id']}
              {/foreach}
            </select>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="category_order" value="{$data['category_order']}">
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