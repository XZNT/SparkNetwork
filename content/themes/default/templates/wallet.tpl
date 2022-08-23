{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_wallet_aym5.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="inner">
    <h2>{__("Wallet")}</h2>
    <p class="text-xlg">{__("Send and Transfer Money")}</p>
  </div>
</div>
<!-- page header -->

<!-- page content -->
<div class="container offcanvas" style="margin-top: -25px;">
  <div class="row">

    <!-- side panel -->
    <div class="col-12 d-block d-md-none offcanvas-sidebar">
      {include file='_sidebar.tpl'}
    </div>
    <!-- side panel -->

    <!-- content panel -->
    <div class="col-12 offcanvas-mainbar">

      <!-- tabs -->
      <div class="content-tabs rounded-sm shadow-sm clearfix">
        <ul>
          <li {if $view == ""}class="active" {/if}>
            <a href="{$system['system_url']}/wallet"><i class="fa fa-wallet mr5"></i>{__("Wallet")}</a>
          </li>
          {if $system['wallet_withdrawal_enabled']}
            <li {if $view == "payments"}class="active" {/if}>
              <a href="{$system['system_url']}/wallet/payments"><i class="fa fa-money-check-alt mr5"></i>{__("Payments")}</a>
            </li>
          {/if}
        </ul>
      </div>
      <!-- tabs -->

      {if $view == ""}

        <!-- wallet -->
        <div class="card mt20">
          <div class="card-header with-icon">
            <i class="fa fa-wallet mr10"></i>{__("Wallet")}
          </div>
          <div class="card-body">
            {if $wallet_transfer_amount}
              <div class="alert alert-success mb20">
                <i class="fas fa-check-circle mr5"></i>
                {__("Your")} <span class="badge badge-pill badge-lg badge-light">{print_money($wallet_transfer_amount|number_format:2)}</span> {__("transfer transaction successfuly sent")}
              </div>
            {/if}
            {if $wallet_replenish_amount}
              <div class="alert alert-success mb20">
                <i class="fas fa-check-circle mr5"></i>
                {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge badge-pill badge-lg badge-light">{print_money($wallet_replenish_amount|number_format:2)}</span>
              </div>
            {/if}
            {if $wallet_withdraw_affiliates_amount}
              <div class="alert alert-success mb20">
                <i class="fas fa-check-circle mr5"></i>
                {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge badge-pill badge-lg badge-light">{print_money($wallet_withdraw_affiliates_amount|number_format:2)}</span> {__("from your affiliates credit")}
              </div>
            {/if}
            {if $wallet_withdraw_points_amount}
              <div class="alert alert-success mb20">
                <i class="fas fa-check-circle mr5"></i>
                {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge badge-pill badge-lg badge-light">{print_money($wallet_withdraw_points_amount|number_format:2)}</span> {__("from your points credit")}
              </div>
            {/if}
            {if $wallet_withdraw_funding_amount}
              <div class="alert alert-success mb20">
                <i class="fas fa-check-circle mr5"></i>
                {__("Congratulation! Your wallet credit replenished successfully with")} <span class="badge badge-pill badge-lg badge-light">{print_money($wallet_withdraw_funding_amount|number_format:2)}</span> {__("from your funding credit")}
              </div>
            {/if}
            {if $wallet_package_payment_amount}
              <div class="alert alert-success mb20">
                <i class="fas fa-check-circle mr5"></i>
                {__("Your")} <span class="badge badge-pill badge-lg badge-light">{print_money($wallet_package_payment_amount|number_format:2)}</span> {__("payment transaction successfuly done")}
              </div>
            {/if}

            <div class="row">
              <!-- credit -->
              <div class="col-md-5">
                <div class="section-title mb20">
                  <i class="fa fa-money-bill-alt mr10"></i> {__("Your Credit")}
                </div>
                <div class="stat-panel bg-gradient-info">
                  <div class="stat-cell small">
                    <i class="fa fa-money-bill-alt bg-icon"></i>
                    <div class="h3 mtb10">
                      {print_money($user->_data['user_wallet_balance']|number_format:2)}
                    </div>
                  </div>
                </div>
              </div>
              <!-- credit -->

              <!-- send & recieve money -->
              <div class="col-md-7">
                <div class="section-title mb20">
                  <i class="fas fa-donate mr10"></i> {__("Send & Recieve Money")}
                </div>
                {if $system['wallet_transfer_enabled']}
                  <button class="btn btn-success btn-block mb10" data-toggle="modal" data-url="#wallet-transfer">
                    <i class="fa fa-gift"></i> {__("Send Money")}
                  </button>
                {/if}

                <div>
                  <button class="btn btn-primary btn-block mb10" data-toggle="modal" data-url="#wallet-replenish">
                    <i class="fab fa-paypal mr5"></i>{__("Replenish Credit")}
                  </button>
                  {if $system['affiliates_enabled'] && $system['affiliates_money_transfer_enabled']}
                    <button class="btn btn-primary btn-block mb10" data-toggle="modal" data-url="#wallet-withdraw-affiliates">
                      <i class="fa fa-exchange-alt mr5"></i>{__("Affiliates Credit")}
                    </button>
                  {/if}
                  {if $system['points_enabled'] && $system['points_money_transfer_enabled']}
                    <button class="btn btn-primary btn-block mb10" data-toggle="modal" data-url="#wallet-withdraw-points">
                      <i class="fa fa-piggy-bank mr5"></i>{__("Points Credit")}
                    </button>
                  {/if}
                  {if $user->_data['can_raise_funding'] && $system['funding_money_transfer_enabled']}
                    <button class="btn btn-primary btn-block mb10" data-toggle="modal" data-url="#wallet-withdraw-funding">
                      <i class="fa fa-hand-holding-usd mr5"></i>{__("Funding Credit")}
                    </button>
                  {/if}
                </div>
              </div>
              <!-- send & recieve money -->

              <!-- wallet transactions -->
              <div class="col-12">
                <div class="section-title mt10 mb20">
                  <i class="fas fa-file-alt mr10"></i> {__("Wallet Transactions")}
                </div>
                {if $transactions}
                  <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover js_dataTable">
                      <thead>
                        <tr>
                          <th>{__("ID")}</th>
                          <th>{__("Amount")}</th>
                          <th>{__("From / To")}</th>
                          <th>{__("Time")}</th>
                        </tr>
                      </thead>
                      <tbody>
                        {foreach $transactions as $transaction}
                          <tr>
                            <td>{$transaction['transaction_id']}</td>
                            <td>
                              {if $transaction['type'] == "out"}
                                <span class="badge badge-pill badge-lg badge-danger mr5"><i class="far fa-arrow-alt-circle-down"></i></span>
                                <strong class="text-danger">{print_money($transaction['amount']|number_format:2)}</strong>
                              {else}
                                <span class="badge badge-pill badge-lg badge-success mr5"><i class="far fa-arrow-alt-circle-up"></i></span>
                                <strong class="text-success">{print_money($transaction['amount']|number_format:2)}</strong>
                              {/if}
                            </td>
                            <td>
                              {if $transaction['type'] == "out"}
                                <span class="badge badge-pill badge-lg badge-danger mr10">{__("To")}</span>
                              {else}
                                <span class="badge badge-pill badge-lg badge-success mr10">{__("From")}</span>
                              {/if}
                              {if $transaction['node_type'] == "user"}
                                <a target="_blank" href="{$system['system_url']}/{$transaction['user_name']}">
                                  <img class="tbl-image" src="{$transaction['user_picture']}" style="float: none;">
                                  {if $system['show_usernames_enabled']}
                                    {$transaction['user_name']}
                                  {else}
                                    {$transaction['user_firstname']} {$transaction['user_lastname']}
                                  {/if}
                                </a>
                              {elseif $transaction['node_type'] == "recharge"}
                                {__("Replenish Credit")}
                              {elseif $transaction['node_type'] == "withdraw_wallet"}
                                {__("Wallet Withdrawal")}
                              {elseif $transaction['node_type'] == "withdraw_affiliates"}
                                {__("Affiliates Credit")}
                              {elseif $transaction['node_type'] == "withdraw_points"}
                                {__("Points Credit")}
                              {elseif $transaction['node_type'] == "withdraw_funding"}
                                {__("Funding Credit")}
                              {elseif $transaction['node_type'] == "package_payment"}
                                {__("Buy Pro Package")}
                              {/if}
                            </td>
                            <td><span class="js_moment" data-time="{$transaction['date']}">{$transaction['date']}</span></td>
                          </tr>
                        {/foreach}
                      </tbody>
                    </table>
                  </div>
                {else}
                  {include file='_no_transactions.tpl'}
                {/if}
              </div>
              <!-- wallet transactions -->
            </div>
          </div>
        </div>
        <!-- wallet -->

      {elseif $view == "payments"}

        <!-- payments -->
        <div class="card mt20">
          <div class="card-header with-icon">
            <i class="fa fa-money-check-alt mr10"></i>{__("Wallet Payments")}
          </div>
          <div class="card-body">
            <div class="section-title mt10 mb20">
              {__("Withdrawal Request")}
            </div>
            <form class="js_ajax-forms" data-url="users/withdraw.php?type=wallet">
              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Your Balance")}
                </label>
                <div class="col-md-9">
                  <h6>
                    <span class="badge badge-lg badge-info">
                      {print_money($user->_data['user_wallet_balance']|number_format:2)}
                    </span>
                  </h6>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Amount")} ({$system['system_currency']})
                </label>
                <div class="col-md-9">
                  <input type="text" class="form-control" name="amount">
                  <span class="form-text">
                    {__("The minimum withdrawal request amount is")} {print_money($system['wallet_min_withdrawal'])}
                  </span>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Payment Method")}
                </label>
                <div class="col-md-9">
                  {if in_array("paypal", $system['wallet_payment_method_array'])}
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" name="method" id="method_paypal" value="paypal" class="custom-control-input">
                      <label class="custom-control-label" for="method_paypal">{__("PayPal")}</label>
                    </div>
                  {/if}
                  {if in_array("skrill", $system['wallet_payment_method_array'])}
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" name="method" id="method_skrill" value="skrill" class="custom-control-input">
                      <label class="custom-control-label" for="method_skrill">{__("Skrill")}</label>
                    </div>
                  {/if}
                  {if in_array("bank", $system['wallet_payment_method_array'])}
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" name="method" id="method_bank" value="bank" class="custom-control-input">
                      <label class="custom-control-label" for="method_bank">{__("Bank Transfer")}</label>
                    </div>
                  {/if}
                  {if in_array("custom", $system['wallet_payment_method_array'])}
                    <div class="custom-control custom-radio custom-control-inline">
                      <input type="radio" name="method" id="method_custom" value="custom" class="custom-control-input">
                      <label class="custom-control-label" for="method_custom">{__($system['wallet_payment_method_custom'])}</label>
                    </div>
                  {/if}
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Transfer To")}
                </label>
                <div class="col-md-9">
                  <input type="text" class="form-control" name="method_value">
                </div>
              </div>

              <div class="form-group form-row">
                <div class="col-md-9 offset-md-3">
                  <button type="submit" class="btn btn-primary">{__("Make a withdrawal")}</button>
                </div>
              </div>

              <!-- success -->
              <div class="alert alert-success mb0 x-hidden"></div>
              <!-- success -->

              <!-- error -->
              <div class="alert alert-danger mb0 x-hidden"></div>
              <!-- error -->
            </form>
            <div class="section-title mt10 mb20">
              {__("Withdrawal History")}
            </div>
            {if $payments}
              <div class="table-responsive mt20">
                <table class="table table-striped table-bordered table-hover">
                  <thead>
                    <tr>
                      <th>{__("ID")}</th>
                      <th>{__("Amount")}</th>
                      <th>{__("Method")}</th>
                      <th>{__("Transfer To")}</th>
                      <th>{__("Time")}</th>
                      <th>{__("Status")}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {foreach $payments as $payment}
                      <tr>
                        <td>{$payment@iteration}</td>
                        <td>{print_money($payment['amount']|number_format:2)}</td>
                        <td>
                          {if $payment['method'] == "custom"}
                            {$system['wallet_payment_method_custom']}
                          {else}
                            {$payment['method']|ucfirst}
                          {/if}
                        </td>
                        <td>{$payment['method_value']}</td>
                        <td>
                          <span class="js_moment" data-time="{$payment['time']}">{$payment['time']}</span>
                        </td>
                        <td>
                          {if $payment['status'] == '0'}
                            <span class="badge badge-pill badge-lg badge-warning">{__("Pending")}</span>
                          {elseif $payment['status'] == '1'}
                            <span class="badge badge-pill badge-lg badge-success">{__("Approved")}</span>
                          {else}
                            <span class="badge badge-pill badge-lg badge-danger">{__("Declined")}</span>
                          {/if}
                        </td>
                      </tr>
                    {/foreach}
                  </tbody>
                </table>
              </div>
            {else}
              {include file='_no_transactions.tpl'}
            {/if}
          </div>
        </div>
        <!-- payments -->

      {/if}
    </div>
    <!-- content panel -->

  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}