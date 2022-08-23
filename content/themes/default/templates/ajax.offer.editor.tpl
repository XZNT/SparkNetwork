<div class="modal-header">
  <h6 class="modal-title">
    <i class="fas fa-tag mr5"></i>{__("Edit Offer")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<form class="js_ajax-forms" data-url="posts/edit.php">
  <div class="modal-body">
    <div class="row">
      <!-- discount type -->
      <div class="form-group col-md-6">
        <label class="form-control-label">{__("Type")}</label>
        <select id="js_discount-type" name="discount_type" class="form-control">
          <option value="discount_percent" {if $post['offer']['discount_type'] == "discount_percent"}selected{/if}>{__("Discount Percent")}</option>
          <option value="discount_amount" {if $post['offer']['discount_type'] == "discount_amount"}selected{/if}>{__("Discount Amount")}</option>
          <option value="buy_get_discount" {if $post['offer']['discount_type'] == "buy_get_discount"}selected{/if}>{__("Buy X Get Y Discount")}</option>
          <option value="spend_get_off" {if $post['offer']['discount_type'] == "spend_get_off"}selected{/if}>{__("Spend X Get Y Off")}</option>
          <option value="free_shipping" {if $post['offer']['discount_type'] == "free_shipping"}selected{/if}>{__("Free Shipping")}</option>
        </select>
      </div>
      <!-- discount type -->
      <!-- discount percent -->
      <div id="js_discount-percent" class="form-group col-md-6 {if $post['offer']['discount_type'] != "discount_percent"}x-hidden{/if}">
        <label class="form-control-label">{__("Discount Percent")}</label>
        <select name="discount_percent" class="form-control">
          {for $i=1 to 99}
            <option value="{$i}" {if $post['offer']['discount_percent'] == $i}selected{/if}>{$i}%</option>
          {/for}
        </select>
      </div>
      <!-- discount percent -->
      <!-- discount amount -->
      <div id="js_discount-amount" class="form-group col-md-6 {if $post['offer']['discount_type'] != "discount_amount"}x-hidden{/if}">
        <label class="form-control-label">{__("Discount Amount")}</label>
        <div class="input-group">
          {if $system['system_currency_dir'] == "left"}
            <div class="input-group-prepend">
              <span class="input-group-text">{$system['system_currency_symbol']}</span>
            </div>
          {/if}
          <input name="discount_amount" type="text" class="form-control" placeholder="0.00" value="{$post['offer']['discount_amount']}">
          {if $system['system_currency_dir'] == "right"}
            <div class="input-group-append">
              <span class="input-group-text">{$system['system_currency_symbol']}</span>
            </div>
          {/if}
        </div>
      </div>
      <!-- discount amount -->
    </div>
    <!-- buy get discount -->
    <div id="js_buy-get-discount" {if $post['offer']['discount_type'] != "buy_get_discount"}class="x-hidden" {/if}>
      <div class="row">
        <div class="form-group col-md-6">
          <label class="form-control-label">{__("Buy")}</label>
          <input name="buy_x" type="text" class="form-control" value="{$post['offer']['buy_x']}">
          <span class="form-text">
            {__("Enter numric value (Example: 5)")}
          </span>
        </div>
        <div class="form-group col-md-6">
          <label class="form-control-label">{__("Get")}</label>
          <input name="get_y" type="text" class="form-control" value="{$post['offer']['get_y']}">
          <span class="form-text">
            {__("Enter numric value (Example: 2)")}
          </span>
        </div>
      </div>
    </div>
    <!-- buy get discount -->
    <!-- spend get off -->
    <div id="js_spend-get-off" {if $post['offer']['discount_type'] != "spend_get_off"}class="x-hidden" {/if}>
      <div class="row">
        <div class="form-group col-md-6">
          <label class="form-control-label">{__("Spend")}</label>
          <div class="input-group">
            {if $system['system_currency_dir'] == "left"}
              <div class="input-group-prepend">
                <span class="input-group-text">{$system['system_currency_symbol']}</span>
              </div>
            {/if}
            <input name="spend_x" type="text" class="form-control" placeholder="0.00" value="{$post['offer']['spend_x']}">
            {if $system['system_currency_dir'] == "right"}
              <div class="input-group-append">
                <span class="input-group-text">{$system['system_currency_symbol']}</span>
              </div>
            {/if}
          </div>
        </div>
        <div class="form-group col-md-6">
          <label class="form-control-label">{__("Amount Off")}</label>
          <div class="input-group">
            {if $system['system_currency_dir'] == "left"}
              <div class="input-group-prepend">
                <span class="input-group-text">{$system['system_currency_symbol']}</span>
              </div>
            {/if}
            <input name="amount_y" type="text" class="form-control" placeholder="0.00" value="{$post['offer']['amount_y']}">
            {if $system['system_currency_dir'] == "right"}
              <div class="input-group-append">
                <span class="input-group-text">{$system['system_currency_symbol']}</span>
              </div>
            {/if}
          </div>
        </div>
      </div>
    </div>
    <!-- spend get off -->
    <div class="row">
      <!-- end date -->
      <div class="form-group col-md-6">
        <label class="form-control-label">{__("End Date")}</label>
        <div class="input-group date js_datetimepicker" id="end_date" data-target-input="nearest">
          <input type='text' class="form-control datetimepicker-input" data-target="#end_date" name="end_date" value="{get_datetime($post['offer']['end_date'])}" />
          <div class="input-group-append" data-target="#end_date" data-toggle="datetimepicker">
            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
          </div>
        </div>
      </div>
      <!-- end date -->
      <!-- category -->
      <div class="form-group col-md-6">
        <label class="form-control-label">{__("Category")}</label>
        <select name="category" class="form-control">
          {foreach $offers_categories as $category}
            {include file='__categories.recursive_options.tpl' data_category=$post['offer']['category_id']}
          {/foreach}
        </select>
      </div>
      <!-- category -->
    </div>

    <!-- title -->
    <div class="form-group">
      <label class="form-control-label">{__("Discounted Items and/or Services")}</label>
      <input name="title" type="text" class="form-control" value="{$post['offer']['title']}">
    </div>
    <!-- title -->
    <!-- description -->
    <div class="form-group">
      <label class="form-control-label">{__("Description")}</label>
      <textarea name="description" rows="5" dir="auto" class="form-control">{$post['text_plain']}</textarea>
    </div>
    <!-- description -->
    <!-- custom fields -->
    {if $custom_fields['basic']}
      {include file='__custom_fields.tpl' _custom_fields=$custom_fields['basic'] _registration=false}
    {/if}
    <!-- custom fields -->
    <!-- thumbnail -->
    <div class="form-group">
      <label class="form-control-label">{__("Thumbnail")}</label>
      <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$post['offer']['thumbnail']}')">
        <div class="x-image-loader">
          <div class="progress x-progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
        <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
        <input type="hidden" class="js_x-image-input" name="thumbnail" value="{$post['offer']['thumbnail']}">
      </div>
    </div>
    <!-- thumbnail -->
    <!-- error -->
    <div class="alert alert-danger mb0 x-hidden"></div>
    <!-- error -->
  </div>
  <div class="modal-footer">
    <input type="hidden" name="handle" value="offer">
    <input type="hidden" name="id" value="{$post['post_id']}">
    <button type="button" class="btn btn-light" data-dismiss="modal">{__("Cancel")}</button>
    <button type="submit" class="btn btn-primary">{__("Save")}</button>
  </div>
</form>

<script>
  $(function() {
    /* handle offer input dependencies */
    $('#js_discount-type').on('change', function() {
      switch ($(this).val()) {
        case "discount_percent":
          $("#js_discount-percent").show();
          $("#js_discount-amount").hide();
          $("#js_buy-get-discount").hide();
          $("#js_spend-get-off").hide();
          break;

        case "discount_amount":
          $("#js_discount-percent").hide();
          $("#js_discount-amount").show();
          $("#js_buy-get-discount").hide();
          $("#js_spend-get-off").hide();
          break;

        case "buy_get_discount":
          $("#js_discount-percent").hide();
          $("#js_discount-amount").hide();
          $("#js_buy-get-discount").show();
          $("#js_spend-get-off").hide();
          break;

        case "spend_get_off":
          $("#js_discount-percent").hide();
          $("#js_discount-amount").hide();
          $("#js_buy-get-discount").hide();
          $("#js_spend-get-off").show();
          break;

        case "free_shipping":
          $("#js_discount-percent").hide();
          $("#js_discount-amount").hide();
          $("#js_buy-get-discount").hide();
          $("#js_spend-get-off").hide();
          break;
      }
    });
  })
</script>