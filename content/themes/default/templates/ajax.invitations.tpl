<div class="modal-header">
  <h6 class="modal-title">
    <i class="fa fa-share mr5"></i>{__("Share Invitation Code")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<form class="js_ajax-forms" data-url="users/invitations.php?do=send">
  <div class="modal-body">
    <div class="text-center">
      <div class="text-xlg">
        {__("Your invitation code is")}
      </div>
      <h3>
        <span class="badge badge-warning">{$code}</span>
      </h3>
    </div>

    <div class="divider"></div>

    <div class="h5 text-center">
      {__("Share the code to")}
    </div>

    <div class="post-social-share">
      <a href="http://www.facebook.com/sharer.php?u={$system['system_url']}/signup?invitation_code={$code}" class="btn btn-sm btn-rounded btn-social-icon btn-facebook" target="_blank">
        <i class="fab fa-facebook-f"></i>
      </a>
      <a href="https://twitter.com/intent/tweet?url={$system['system_url']}/signup?invitation_code={$code}" class="btn btn-sm btn-rounded btn-social-icon btn-rounded btn-twitter" target="_blank">
        <i class="fab fa-twitter"></i>
      </a>
      <a href="https://vk.com/share.php?url={$system['system_url']}/signup?invitation_code={$code}" class="btn btn-sm btn-rounded btn-social-icon btn-vk" target="_blank">
        <i class="fab fa-vk"></i>
      </a>
      <a href="https://www.linkedin.com/shareArticle?mini=true&url={$system['system_url']}/signup?invitation_code={$code}" class="btn btn-sm btn-rounded btn-social-icon btn-linkedin" target="_blank">
        <i class="fab fa-linkedin"></i>
      </a>
      <a href="https://api.whatsapp.com/send?text={$system['system_url']}/signup?invitation_code={$code}" class="btn btn-sm btn-rounded btn-social-icon btn-whatsapp d-none d-sm-inline-block" target="_blank">
        <i class="fab fa-whatsapp"></i>
      </a>
      <a href="https://reddit.com/submit?url={$system['system_url']}/signup?invitation_code={$code}" class="btn btn-sm btn-rounded btn-social-icon btn-reddit" target="_blank">
        <i class="fab fa-reddit"></i>
      </a>
      <a href="https://pinterest.com/pin/create/button/?url={$system['system_url']}/signup?invitation_code={$code}" class="btn btn-sm btn-rounded btn-social-icon btn-pinterest" target="_blank">
        <i class="fab fa-pinterest"></i>
      </a>
    </div>

    <!-- send method -->
    <div class="mb20 text-center">
      {if $system['invitation_send_method'] == "email" || $system['invitation_send_method'] == "both"}
        <!-- Email -->
        <input class="x-hidden input-label" type="radio" name="send_method" id="send_method_email" value="email" checked="checked" />
        <label class="button-label" for="send_method_email">
          <div class="icon">
            {include file='__svg_icons.tpl' icon="email" width="32px" height="32px"}
          </div>
          <div class="title">{__("Email")}</div>
        </label>
        <!-- Email -->
      {/if}

      {if $system['invitation_send_method'] == "sms" || $system['invitation_send_method'] == "both"}
        <!-- SMS -->
        <input class="x-hidden input-label" type="radio" name="send_method" id="send_method_sms" value="sms" />
        <label class="button-label" for="send_method_sms">
          <div class="icon">
            {include file='__svg_icons.tpl' icon="sms" width="32px" height="32px"}
          </div>
          <div class="title">{__("SMS")}</div>
        </label>
        <!-- SMS -->
      {/if}
    </div>
    <!-- send method -->

    <div id="js_method-email" {if $system['invitation_send_method'] == "sms"}class="x-hidden" {/if}>
      <div class="form-group">
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
          </div>
          <input type="email" class="form-control" name="email">
        </div>
      </div>
    </div>

    <div id="js_method-sms" class="x-hidden">
      <div class="form-group">
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text"><i class="fas fa-globe-americas"></i></span>
          </div>
          <input type="text" class="form-control" name="phone">
          <div class="input-group-append">
            <span class="input-group-text"><i class="fas fa-phone"></i></span>
          </div>
        </div>
        <span class="form-text">
          {__("Phone number i.e +1234567890")}
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
  <div class="modal-footer">
    <input type="hidden" name="code" value="{$code}">
    <button type="button" class="btn btn-light" data-dismiss="modal">{__("Cancel")}</button>
    <button type="submit" class="btn btn-primary">{__("Send")}</button>
  </div>
</form>

<script>
  /* share post */
  $('input[type=radio][name=send_method]').on('change', function() {
    switch ($(this).val()) {
      case 'email':
        $('#js_method-sms').hide();
        $('#js_method-email').fadeIn();
        break;
      case 'sms':
        $('#js_method-email').hide();
        $('#js_method-sms').fadeIn();
        break;
    }
  });
</script>