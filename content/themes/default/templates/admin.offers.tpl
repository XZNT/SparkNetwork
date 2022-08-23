<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == "find"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/offers" class="btn btn-sm btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {elseif $sub_view == "categories"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/offers/add_category" class="btn btn-sm btn-primary">
          <i class="fa fa-plus mr5"></i>{__("Add New Category")}
        </a>
      </div>
    {elseif $sub_view == "add_category" || $sub_view == "edit_category"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/offers/categories" class="btn btn-sm btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {/if}
    <i class="fa fa-tag mr10"></i>{__("Offers")}
    {if $sub_view == "find"} &rsaquo; {__("Find")}{/if}
    {if $sub_view == "categories"} &rsaquo; {__("Categories")}{/if}
    {if $sub_view == "add_category"} &rsaquo; {__("Categories")} &rsaquo; {__("Add New Category")}{/if}
    {if $sub_view == "edit_category"} &rsaquo; {__("Categories")} &rsaquo; {$data['category_name']}{/if}
  </div>

  {if $sub_view == "" || $sub_view == "find"}

    <div class="card-body">

      <!-- search form -->
      <div class="mb20">
        <form class="form-inline" action="{$system['system_url']}/{$control_panel['url']}/offers/find" method="get">
          <div class="form-group mb0">
            <div class="input-group">
              <input type="text" class="form-control" name="query">
              <div class="input-group-append">
                <button type="submit" class="btn btn-sm btn-primary"><i class="fas fa-search mr5"></i>{__("Search")}</button>
              </div>
            </div>
          </div>
        </form>
        <div class="form-text small">
          {__('Search by Offer Title or Description')}
        </div>
      </div>
      <!-- search form -->

      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Page")}</th>
              <th>{__("Title")}</th>
              <th>{__("Time")}</th>
              <th>{__("Link")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {if $rows}
              {foreach $rows as $row}
                <tr>
                  <td>{$row['post_id']}</td>
                  <td>
                    <a target="_blank" href="{$system['system_url']}/pages/{$row['page_name']}">
                      <img class="tbl-image" src="{$row['page_picture']}">
                      {$row['page_title']}
                    </a>
                  </td>
                  <td>
                    <span title="{$row['title']}">{$row['title']|truncate:30}</span>
                  </td>
                  <td><span class="js_moment" data-time="{$row['time']}">{$row['time']}</span></td>
                  <td>
                    <a class="btn btn-sm btn-light" href="{$system['system_url']}/posts/{$row['post_id']}" target="_blank">
                      <i class="fa fa-eye mr5"></i>{__("View")}
                    </a>
                  </td>
                  <td>
                    <button data-toggle="tooltip" data-placement="top" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="post" data-id="{$row['post_id']}">
                      <i class="fa fa-trash-alt"></i>
                    </button>
                  </td>
                </tr>
              {/foreach}
            {else}
              <tr>
                <td colspan="6" class="text-center">
                  {__("No data to show")}
                </td>
              </tr>
            {/if}
          </tbody>
        </table>
      </div>

      {$pager}

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
                {include file='__categories.recursive_rows.tpl' _url="offers" _handle="offers_category"}
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

    <form class="js_ajax-forms" data-url="admin/offers.php?do=add_category">
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

    <form class="js_ajax-forms" data-url="admin/offers.php?do=edit_category&id={$data['category_id']}">
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