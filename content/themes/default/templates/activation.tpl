{include file='_head.tpl'}
{include file='_header.tpl'}

<!-- page header -->
<div class="page-header">
  <img class="floating-img d-none d-md-block" src="{$system['system_url']}/content/themes/{$system['theme']}/images/headers/undraw_check_boxes_re_v40f.svg">
  <div class="circle-2"></div>
  <div class="circle-3"></div>
  <div class="inner">
    <h2>{__("Activation Required")}</h2>
    <p class="text-xlg">{__("You have to activate your account before you start")}</p>
  </div>
</div>
<!-- page header -->

<!-- page content -->
<div class="container" style="margin-top: -25px;">
  <div class="row">
    <div class="col-12 col-md-10 mx-md-auto">
      <div class="card shadow">
        <div class="card-body text-center">

          <h2>{__("Hey")} 👋 {__("Let's verify your")} {if $system['activation_type'] == "email"}{__("Email")}{else}{__("Phone Number")}{/if}</h2>
          <p class="text-xlg mt10 mb30">
            {if $system['activation_type'] == "email"}
              {__("Please go to")} <span class="text-primary">{$user->_data['user_email']}</span> {__("to complete the activation process")}
            {else}
              {__("Please check the SMS on your phone")} <strong>{$user->_data['user_phone']}</strong> {__("to complete the activation process")}
            {/if}
          </p>

          <div>
            {if $system['activation_type'] == "email"}
              <button type="button" class="btn btn-success rounded-pill mr10" data-toggle="modal" data-url="core/activation_email_resend.php">
                {__("Resend Verification Email")}
              </button>
              <button type="button" class="btn btn-primary rounded-pill" data-toggle="modal" data-url="#activation-email-reset">
                {__("Change Email")}
              </button>
            {else}
              <button type="button" class="btn btn-success rounded-pill mr10" data-toggle="modal" data-url="#activation-phone">{__("Enter Code")}</button>
              {if $user->_data['user_phone']}
                <button type="button" class="btn btn-primary rounded-pill" data-toggle="modal" data-url="core/activation_phone_resend.php">
                  {__("Resend SMS")}
                </button>
              {/if}
              <button type="button" class="btn btn-primary rounded-pill" data-toggle="modal" data-url="#activation-phone-reset">
                {__("Change Phone Number")}
              </button>
            {/if}
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- page content -->

{include file='_footer.tpl'}