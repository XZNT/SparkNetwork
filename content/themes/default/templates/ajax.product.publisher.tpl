<div class="modal-header">
  <h6 class="modal-title">
    <i class="fa fa-shopping-cart mr10" style="color: #2b53a4;"></i>{__("Sell New Product")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<form class="publisher-mini">
  <div class="modal-body">
    <div class="form-group">
      <label class="form-control-label">{__("Product Name")}</label>
      <input name="name" type="text" class="form-control">
    </div>
    <div class="row">
      <div class="form-group col-md-8">
        <label class="form-control-label">{__("Price")}</label>
        <input name="price" type="text" class="form-control">
      </div>
      <div class="form-group col-md-4">
        <label class="form-control-label">{__("Currency")}</label>
        <select name="currency" class="form-control">
          {foreach $system["enabled_currencies"] as $currency}
            <option value="{$currency['currency_id']}">{$currency['code']} ({$currency['symbol']})</option>
          {/foreach}
        </select>
      </div>
    </div>
    <div class="row">
      <div class="form-group col-md-8">
        <label class="form-control-label">{__("Category")}</label>
        <select name="category" class="form-control">
          {foreach $market_categories as $category}
            {include file='__categories.recursive_options.tpl'}
          {/foreach}
        </select>
      </div>
      <div class="form-group col-md-4">
        <label class="form-control-label">{__("Status")}</label>
        <select name="status" class="form-control">
          <option value="new">{__("New")}</option>
          <option value="old">{__("Used")}</option>
        </select>
      </div>
    </div>
    <div class="form-group">
      <label class="form-control-label">{__("Location")}</label>
      <input name="location" type="text" class="form-control js_geocomplete">
    </div>
    <div class="form-group">
      <label class="form-control-label">{__("Description")}</label>
      <textarea name="message" rows="5" dir="auto" class="form-control"></textarea>
    </div>
    <!-- custom fields -->
    {if $custom_fields}
      {include file='__custom_fields.tpl' _custom_fields=$custom_fields _registration=true}
    {/if}
    <!-- custom fields -->
    <div class="form-group">
      <label class="form-control-label">{__("Photos")}</label>
      <div class="attachments clearfix" data-type="photos">
        <ul>
          <li class="add">
            <i class="fa fa-camera js_x-uploader" data-handle="publisher-mini" data-multiple="true"></i>
          </li>
        </ul>
      </div>
    </div>
    <!-- error -->
    <div class="alert alert-danger mb0 x-hidden"></div>
    <!-- error -->
  </div>
  <div class="modal-footer">
    <button type="button" class="btn btn-primary js_publisher-btn js_publisher-product">{__("Publish")}</button>
  </div>
</form>