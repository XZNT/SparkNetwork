<div class="card">
  <div class="card-header with-icon">
    {if $sub_view == "find"}
      <div class="float-right">
        <a href="{$system['system_url']}/{$control_panel['url']}/funding/requests" class="btn btn-sm btn-light">
          <i class="fa fa-arrow-circle-left mr5"></i>{__("Go Back")}
        </a>
      </div>
    {/if}
    <i class="fa fa-hand-holding-usd mr10"></i>{__("Funding")}
    {if $sub_view == "payments"} &rsaquo; {__("Payment Requests")}{/if}
    {if $sub_view == "requests"} &rsaquo; {__("Funding Requests")}{/if}
    {if $sub_view == "find"} &rsaquo; {__("Find")}{/if}
  </div>

  {if $sub_view == ""}

    <form class="js_ajax-forms" data-url="admin/settings.php?edit=funding">
      <div class="card-body">
        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="funding" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Funding")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the funding On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="funding_enabled">
              <input type="checkbox" name="funding_enabled" id="funding_enabled" {if $system['funding_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Who Can Raise Funding")}
          </label>
          <div class="col-md-9">
            <select class="form-control selectpicker" name="funding_permission">
              <option value="admins" {if $system['funding_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}</b><span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
              <option value="pro" {if $system['funding_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}</b><span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
              <option value="verified" {if $system['funding_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}</b><span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
              <option value="everyone" {if $system['funding_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}</b><span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
            </select>
          </div>
        </div>

        <div class="divider dashed"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="withdrawal" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Users Can Withdraw Earned Money")}</div>
            <div class="form-text d-none d-sm-block">{__("If enabled users will be able to withdraw earned money")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="funding_money_withdraw_enabled">
              <input type="checkbox" name="funding_money_withdraw_enabled" id="funding_money_withdraw_enabled" {if $system['funding_money_withdraw_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Payment Method")}
          </label>
          <div class="col-md-9">
            <div class="custom-control custom-checkbox custom-control-inline">
              <input type="checkbox" class="custom-control-input" name="method_paypal" id="method_paypal" {if in_array("paypal", $system['funding_payment_method_array'])}checked{/if}>
              <label class="custom-control-label" for="method_paypal">{__("PayPal")}</label>
            </div>
            <div class="custom-control custom-checkbox custom-control-inline">
              <input type="checkbox" class="custom-control-input" name="method_skrill" id="method_skrill" {if in_array("skrill", $system['funding_payment_method_array'])}checked{/if}>
              <label class="custom-control-label" for="method_skrill">{__("Skrill")}</label>
            </div>
            <div class="custom-control custom-checkbox custom-control-inline">
              <input type="checkbox" class="custom-control-input" name="method_bank" id="method_bank" {if in_array("bank", $system['funding_payment_method_array'])}checked{/if}>
              <label class="custom-control-label" for="method_bank">{__("Bank Transfer")}</label>
            </div>
            <div class="custom-control custom-checkbox custom-control-inline" id="js_custome-withdrawal">
              <input type="checkbox" class="custom-control-input" name="method_custom" id="method_custom" {if in_array("custom", $system['funding_payment_method_array'])}checked{/if}>
              <label class="custom-control-label" for="method_custom">{__("Custom Method")}</label>
            </div>
            <span class="form-text">
              {__("Users can send withdrawal requests via any of these methods")}
            </span>
          </div>
        </div>

        <div id="js_custome-withdrawal-name" {if !in_array("custom", $system['funding_payment_method_array'])}class="x-hidden" {/if}>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Custom Method Name")}
            </label>
            <div class="col-md-9">
              <input type="text" class="form-control" name="funding_payment_method_custom" value="{$system['funding_payment_method_custom']}">
              <span class="form-text">
                {__("Set the name of your custom withdrawal payment method")}
              </span>
            </div>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Minimum Withdrawal Request")} ({$system['system_currency']})
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="funding_min_withdrawal" value="{$system['funding_min_withdrawal']}">
            <span class="form-text">
              {__("The minimum amount of money so user can send a withdrawal request")}
            </span>
          </div>
        </div>

        <div class="divider dashed"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="wallet" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Users Can Transfer Earned Money To Wallet")}</div>
            <div class="form-text d-none d-sm-block">
              {__("If wallet enabled users will be able to transfer earned money to their wallet")}<br>
              {__("Make sure you have enabled")} <a href="{$system['system_url']}/{$control_panel['url']}/wallet">{__("Wallet System")}</a>
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="funding_money_transfer_enabled">
              <input type="checkbox" name="funding_money_transfer_enabled" id="funding_money_transfer_enabled" {if $system['funding_money_transfer_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider dashed"></div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Commission")} (%)
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="funding_commission" value="{$system['funding_commission']}">
            <span class="form-text">
              {__("Leave it 0 if you don't want to get any commissions")}
            </span>
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

  {elseif $sub_view == "payments"}

    <div class="card-body">
      <div class="alert alert-primary">
        <div class="icon">
          <i class="fa fa-money-check-alt fa-2x"></i>
        </div>
        <div class="text">
          <strong>{__("Payment Requests")}</strong><br>
          {__("You will need to make the payments from your Paypal, Skrill, Bank Account... etc")}.<br>
          {__("After making the payment you can mark the payment request as paid")}.
        </div>
      </div>
      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover js_dataTable">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("User")}</th>
              <th>{__("Amount")}</th>
              <th>{__("Method")}</th>
              <th>{__("Transfer To")}</th>
              <th>{__("Actions")}</th>
            </tr>
          </thead>
          <tbody>
            {foreach $rows as $row}
              <tr>
                <td>{$row['payment_id']}</td>
                <td>
                  <a target="_blank" href="{$system['system_url']}/{$row['user_name']}">
                    <img class="tbl-image" src="{$row['user_picture']}">
                    {if $system['show_usernames_enabled']}{$row['user_name']}{else}{$row['user_firstname']} {$row['user_lastname']}{/if}
                  </a>
                </td>
                <td>{print_money($row['amount']|number_format:2)}</td>
                <td>
                  <span class="badge badge-pill badge-lg badge-{$row['method_color']}">
                    {$row['method']|ucfirst}
                  </span>
                </td>
                <td>{$row['method_value']}</td>
                <td>
                  <button data-toggle="tooltip" data-placement="top" title='{__("Mark as Paid")}' class="btn btn-sm btn-icon btn-rounded btn-success js_admin-withdraw" data-type="funding" data-handle="approve" data-id="{$row['payment_id']}">
                    <i class="fa fa-check"></i>
                  </button>
                  <button data-toggle="tooltip" data-placement="top" title='{__("Decline")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-withdraw" data-type="funding" data-handle="decline" data-id="{$row['payment_id']}">
                    <i class="fa fa-times"></i>
                  </button>
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    </div>

  {elseif $sub_view == "requests" || $sub_view == "find"}

    <div class="card-body">

      <!-- search form -->
      <div class="mb20">
        <form class="form-inline" action="{$system['system_url']}/{$control_panel['url']}/funding/find" method="get">
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
          {__('Search by Funding Title or Description')}
        </div>
      </div>
      <!-- search form -->

      <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
              <th>{__("ID")}</th>
              <th>{__("Author")}</th>
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
                    <a target="_blank" href="{$row['post_author_url']}">
                      <img class="tbl-image" src="{$row['post_author_picture']}">
                      {$row['post_author_name']}
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

  {/if}
</div>