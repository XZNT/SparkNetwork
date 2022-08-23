<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == "packages"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/pro/add" class="btn btn-sm btn-primary">
          <i class="fa fa-plus mr5"></i>{__("Add New Package")}
        </a>
      </div>
    {elseif $sub_view == "add" || $sub_view == "edit"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/pro/packages" class="btn btn-sm btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {/if}
    <i class="fa fa-cubes mr5"></i>{__("Pro System")}
    {if $sub_view == "packages"} &rsaquo; {__("Packages")}{/if}
    {if $sub_view == "edit"} &rsaquo; {$data['name']}{/if}
    {if $sub_view == "add"} &rsaquo; {__("Add New Package")}{/if}
    {if $sub_view == "subscribers"} &rsaquo; {__("Subscribers")}{/if}
    {if $sub_view == "earnings"} &rsaquo; {__("Earnings")}{/if}
  </div>

  {if $sub_view == ""}

    <form class="js_ajax-forms" data-url="admin/pro.php?do=settings">
      <div class="card-body">
        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="pro_packages" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Pro Packages Enabled")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Enable pro packages to be used as upgrading plans or for subscriptions")}<br>
              {__("Make sure you have configured")} <a href="{$system['system_url']}/{$control_panel['url']}/settings/payments">{__("Payments Settings")}</a>
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="packages_enabled">
              <input type="checkbox" name="packages_enabled" id="packages_enabled" {if $system['packages_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="wallet" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Users Can Buy Packages From Wallet Balance")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Enable users to buy packages from their wallet balance")}<br>
              {__("Make sure you have enabled")} <a href="{$system['system_url']}/{$control_panel['url']}/wallet">{__("Wallet System")}</a>
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="packages_wallet_payment_enabled">
              <input type="checkbox" name="packages_wallet_payment_enabled" id="packages_wallet_payment_enabled" {if $system['packages_wallet_payment_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
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

  {elseif $sub_view == "packages"}

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Name")}</th>
              <th>{__("Price")}</th>
              <th>{__("Period")}</th>
              <th>{__("Boost Posts")}</th>
              <th>{__("Boost Pages")}</th>
              <th>{__("Order")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td>{$row['package_id']}</td>
                <td>
                  <a target="_blank" href="{$system['system_url']}/{$control_panel['url']}/pro/edit/{$row['package_id']}">
                    <img class="tbl-image" src="{$row['icon']}">
                    {$row['name']}
                  </a>
                </td>
                <td>{print_money($row['price'])}</td>
                <td>
                  {if $row['period'] == 'life'}
                    {__("Life Time")}
                  {else}
                    {$row['period_num']} {$row['period']|ucfirst}
                  {/if}
                </td>
                <td>{$row['boost_posts']}</td>
                <td>{$row['boost_pages']}</td>
                <td>{$row['package_order']}</td>
                <td>
                  <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' href="{$system['system_url']}/{$control_panel['url']}/pro/edit/{$row['package_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                    <i class="fa fa-pencil-alt"></i>
                  </a>
                  <button data-toggle="tooltip" data-placement="top" title='{__("Delete")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-deleter" data-handle="package" data-id="{$row['package_id']}">
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

    <form class="js_ajax-forms" data-url="admin/pro.php?do=edit&id={$data['package_id']}">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="name" value="{$data['name']}">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Price")} ({$system['system_currency']})
          </label>
          <div class="col-md-9">
            <input class="form-control" name="price" value="{$data['price']}">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Paid Every")}
          </label>
          <div class="col-md-9">
            <div class="form-row">
              <div class="col-sm-8">
                <input class="form-control" name="period_num" value="{$data['period_num']}">
              </div>
              <div class="col-sm-4">
                <select class="form-control" name="period">
                  <option {if $data['period'] == "day"}selected{/if} value="day">{__("Day")}</option>
                  <option {if $data['period'] == "week"}selected{/if} value="week">{__("Week")}</option>
                  <option {if $data['period'] == "month"}selected{/if} value="month">{__("Month")}</option>
                  <option {if $data['period'] == "year"}selected{/if} value="year">{__("Year")}</option>
                  <option {if $data['period'] == "life"}selected{/if} value="life">{__("Life Time")}</option>
                </select>
              </div>
            </div>
            <span class="form-text">
              {__("For example 15 days, 2 Months, 1 Year")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Color")}
          </label>
          <div class="col-md-9">
            <div class="input-group js_colorpicker">
              <input type="text" class="form-control" name="color" value="{$data['color']}" />
              <span class="input-group-append">
                <span class="input-group-text colorpicker-input-addon"><i></i></span>
              </span>
            </div>
            <span class="form-text">
              {__("The theme color for this package")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Icon")}
          </label>
          <div class="col-md-9">
            {if $data['icon'] == ''}
              <div class="x-image">
                <button type="button" class="close x-hidden js_x-image-remover" title='{__("Remove")}'>
                  <span>×</span>
                </button>
                <div class="x-image-loader">
                  <div class="progress x-progress">
                    <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                </div>
                <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
                <input type="hidden" class="js_x-image-input" name="icon" value="">
              </div>
            {else}
              <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$data['icon']}')">
                <button type="button" class="close js_x-image-remover" title='{__("Remove")}'>
                  <span>×</span>
                </button>
                <div class="x-image-loader">
                  <div class="progress x-progress">
                    <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                </div>
                <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
                <input type="hidden" class="js_x-image-input" name="icon" value="{$data['icon']}">
              </div>
            {/if}
            <span class="form-text">
              {__("The perfect size for icon should be (wdith: 60px & height: 60px)")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Verification Badge Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="verification_badge_enabled">
              <input type="checkbox" name="verification_badge_enabled" id="verification_badge_enabled" {if $data['verification_badge_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Enable verification badge with this package")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Boost Posts Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="boost_posts_enabled">
              <input type="checkbox" name="boost_posts_enabled" id="boost_posts_enabled" {if $data['boost_posts_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Enable boost posts feature")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Posts Boosts")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="boost_posts" value="{$data['boost_posts']}">
            <span class="form-text">
              {__("Max posts boosts allowed")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Boost Pages Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="boost_pages_enabled">
              <input type="checkbox" name="boost_pages_enabled" id="boost_pages_enabled" {if $data['boost_pages_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Enable boost pages feature")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Pages Boosts")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="boost_pages" value="{$data['boost_pages']}">
            <span class="form-text">
              {__("Max pages boosts allowed")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Custom Description")}
          </label>
          <div class="col-md-9">
            <textarea class="form-control" name="custom_description" rows="5">{$data['custom_description']}</textarea>
            <span class="form-text">
              {__("Add more text to show it to your users")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="package_order" value="{$data['package_order']}">
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

    <form class="js_ajax-forms" data-url="admin/pro.php?do=add">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Name")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="name">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Price")} ({$system['system_currency']})
          </label>
          <div class="col-md-9">
            <input class="form-control" name="price">
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Paid Every")}
          </label>
          <div class="col-md-9">
            <div class="form-row">
              <div class="col-sm-8">
                <input class="form-control" name="period_num">
              </div>
              <div class="col-sm-4">
                <select class="form-control" name="period">
                  <option value="day">{__("Day")}</option>
                  <option value="week">{__("Week")}</option>
                  <option value="month">{__("Month")}</option>
                  <option value="year">{__("Year")}</option>
                  <option value="life">{__("Life Time")}</option>
                </select>
              </div>
            </div>
            <span class="form-text">
              {__("For example 15 days, 2 Months, 1 Year")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Color")}
          </label>
          <div class="col-md-9">
            <div class="input-group js_colorpicker">
              <input type="text" class="form-control" name="color" />
              <span class="input-group-append">
                <span class="input-group-text colorpicker-input-addon"><i></i></span>
              </span>
            </div>
            <span class="form-text">
              {__("The theme color for this package")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Icon")}
          </label>
          <div class="col-md-9">
            <div class="x-image">
              <button type="button" class="close x-hidden js_x-image-remover" title='{__("Remove")}'>
                <span>×</span>
              </button>
              <div class="x-image-loader">
                <div class="progress x-progress">
                  <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
              <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
              <input type="hidden" class="js_x-image-input" name="icon" value="">
            </div>
            <span class="form-text">
              {__("The perfect size for icon should be (wdith: 60px & height: 60px)")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Verification Badge Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="verification_badge_enabled">
              <input type="checkbox" name="verification_badge_enabled" id="verification_badge_enabled">
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Enable verification badge with this package")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Boost Posts Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="boost_posts_enabled">
              <input type="checkbox" name="boost_posts_enabled" id="boost_posts_enabled">
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Enable boost posts feature")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Posts Boosts")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="boost_posts">
            <span class="form-text">
              {__("Max posts boosts allowed")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Boost Pages Enabled")}
          </label>
          <div class="col-md-9">
            <label class="switch" for="boost_pages_enabled">
              <input type="checkbox" name="boost_pages_enabled" id="boost_pages_enabled">
              <span class="slider round"></span>
            </label>
            <span class="form-text">
              {__("Enable boost pages feature")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Pages Boosts")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="boost_pages">
            <span class="form-text">
              {__("Max pages boosts allowed")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Custom Description")}
          </label>
          <div class="col-md-9">
            <textarea class="form-control" name="custom_description" rows="5"></textarea>
            <span class="form-text">
              {__("Add more text to show it to your users")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Order")}
          </label>
          <div class="col-md-9">
            <input class="form-control" name="package_order">
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

  {elseif $sub_view == "subscribers"}

    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("User")}</th>
              <th>{__("Package")}</th>
              <th>{__("Subscription")}</th>
              <th>{__("Expiration")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td><a href="{$system['system_url']}/{$row['user_name']}" target="_blank">{$row['user_id']}</a></td>
                <td>
                  <a target="_blank" href="{$system['system_url']}/{$row['user_name']}">
                    <img class="tbl-image" src="{$row['user_picture']}">
                    {if $system['show_usernames_enabled']}{$row['user_name']}{else}{$row['user_firstname']} {$row['user_lastname']}{/if}
                  </a>
                </td>
                <td>
                  <a target="_blank" href="{$system['system_url']}/{$control_panel['url']}/pro/edit/{$row['package_id']}">
                    <img class="tbl-image" src="{$row['icon']}">
                    {$row['name']}
                  </a>
                </td>
                <td>{$row['user_subscription_date']|date_format:"%e %B %Y"}</td>
                <td>
                  {if $row['period'] == "life"}
                    {__("Life Time")}
                  {else}
                    {$row['subscription_end']|date_format:"%e %B %Y"} ({if $row['subscription_timeleft'] > 0}{__("Remaining")} {$row['subscription_timeleft']} {__("Days")}{else}{__("Expired")}{/if})
                  {/if}
                </td>
                <td>
                  <a data-toggle="tooltip" data-placement="top" title='{__("Edit")}' href="{$system['system_url']}/{$control_panel['url']}/users/edit/{$row['user_id']}" class="btn btn-sm btn-icon btn-rounded btn-primary">
                    <i class="fa fa-pencil-alt"></i>
                  </a>
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    </div>

  {elseif $sub_view == "earnings"}

    <div class="card-body">
      <div class="row">
        <div class="col-sm-6">
          <div class="stat-panel bg-gradient-primary">
            <div class="stat-cell">
              <i class="fa fa-dollar-sign bg-icon"></i>
              <span class="text-xxlg">{print_money($total_earnings|number_format:2)}</span><br>
              <span class="text-lg">{__("Total earnings")}</span><br>
            </div>
          </div>
        </div>
        <div class="col-sm-6">
          <div class="stat-panel bg-gradient-info">
            <div class="stat-cell">
              <i class="fa fa-dollar-sign bg-icon"></i>
              <span class="text-xxlg">{print_money($month_earnings|number_format:2)}</span><br>
              <span class="text-lg">{__("This month earnings")}</span><br>
            </div>
          </div>
        </div>
      </div>

      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("Package")}</th>
              <th>{__("Total Sales")}</th>
              <th>{__("Total Earnings")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $key => $value}
              <tr>
                <td>{$key}</td>
                <td>{$value['sales']}</td>
                <td>{print_money($value['earnings']|number_format:2)}</td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>

      <div id="admin-chart-earnings" class="admin-chart mt20"></div>
    </div>

  {/if}
</div>