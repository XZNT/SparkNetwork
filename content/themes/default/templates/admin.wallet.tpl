<div class="card">
  <div class="card-header with-icon">
    <i class="fa fa-wallet mr10"></i>{__("Wallet")}
  </div>

  {if $sub_view == ""}

    <form class="js_ajax-forms" data-url="admin/settings.php?edit=wallet">
      <div class="card-body">
        <div class="alert alert-warning">
          <div class="icon">
            <i class="fa fa-exclamation-triangle fa-2x"></i>
          </div>
          <div class="text pt5">
            {__("Make sure you have configured")} <a class="alert-link" href="{$system['system_url']}/{$control_panel['url']}/settings/payments">{__("Payments Settings")}</a>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="wallet" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Wallet Enabled")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the wallet On and Off")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="wallet_enabled">
              <input type="checkbox" name="wallet_enabled" id="wallet_enabled" {if $system['wallet_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="wallet_transfer" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Transfer Money Enabled")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the transfer money between users On and Off")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="wallet_transfer_enabled">
              <input type="checkbox" name="wallet_transfer_enabled" id="wallet_transfer_enabled" {if $system['wallet_transfer_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider dashed"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="withdrawal" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Users Can Withdraw Money From Wallet")}</div>
            <div class="form-text d-none d-sm-block">
              {__("If enabled users will be able to withdraw money from their wallets")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="wallet_withdrawal_enabled">
              <input type="checkbox" name="wallet_withdrawal_enabled" id="wallet_withdrawal_enabled" {if $system['wallet_withdrawal_enabled']}checked{/if}>
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
              <input type="checkbox" class="custom-control-input" name="method_paypal" id="method_paypal" {if in_array("paypal", $system['wallet_payment_method_array'])}checked{/if}>
              <label class="custom-control-label" for="method_paypal">{__("PayPal")}</label>
            </div>
            <div class="custom-control custom-checkbox custom-control-inline">
              <input type="checkbox" class="custom-control-input" name="method_skrill" id="method_skrill" {if in_array("skrill", $system['wallet_payment_method_array'])}checked{/if}>
              <label class="custom-control-label" for="method_skrill">{__("Skrill")}</label>
            </div>
            <div class="custom-control custom-checkbox custom-control-inline">
              <input type="checkbox" class="custom-control-input" name="method_bank" id="method_bank" {if in_array("bank", $system['wallet_payment_method_array'])}checked{/if}>
              <label class="custom-control-label" for="method_bank">{__("Bank Transfer")}</label>
            </div>
            <div class="custom-control custom-checkbox custom-control-inline" id="js_custome-withdrawal">
              <input type="checkbox" class="custom-control-input" name="method_custom" id="method_custom" {if in_array("custom", $system['wallet_payment_method_array'])}checked{/if}>
              <label class="custom-control-label" for="method_custom">{__("Custom Method")}</label>
            </div>
            <span class="form-text">
              {__("Users can send withdrawal requests via any of these methods")}
            </span>
          </div>
        </div>

        <div id="js_custome-withdrawal-name" {if !in_array("custom", $system['wallet_payment_method_array'])}class="x-hidden" {/if}>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Custom Method Name")}
            </label>
            <div class="col-md-9">
              <input type="text" class="form-control" name="wallet_payment_method_custom" value="{$system['wallet_payment_method_custom']}">
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
            <input type="text" class="form-control" name="wallet_min_withdrawal" value="{$system['wallet_min_withdrawal']}">
            <span class="form-text">
              {__("The minimum amount of money so user can send a withdrawal request")}
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
                  <button data-toggle="tooltip" data-placement="top" title='{__("Mark as Paid")}' class="btn btn-sm btn-icon btn-rounded btn-success js_admin-withdraw" data-type="wallet" data-handle="approve" data-id="{$row['payment_id']}">
                    <i class="fa fa-check"></i>
                  </button>
                  <button data-toggle="tooltip" data-placement="top" title='{__("Decline")}' class="btn btn-sm btn-icon btn-rounded btn-danger js_admin-withdraw" data-type="wallet" data-handle="decline" data-id="{$row['payment_id']}">
                    <i class="fa fa-times"></i>
                  </button>
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    </div>

  {/if}

</div>