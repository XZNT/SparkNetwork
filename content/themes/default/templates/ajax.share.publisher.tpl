<div class="modal-header">
  <h6 class="modal-title">
    <i class="fa fa-share mr5"></i>{__("Share")}
  </h6>
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<form class="js_ajax-forms" data-url="posts/share.php?do=publish&post_id={$post['post_id']}">
  <div class="modal-body">
    <div style="margin: 25px auto; width: 60%;">
      <div class="input-group">
        <input type="text" disabled class="form-control" value="{$system['system_url']}/posts/{$post['post_id']}">
        <div class="input-group-append">
          <button type="button" class="btn btn-light js_clipboard" data-clipboard-text="{$system['system_url']}/posts/{$post['post_id']}" data-toggle="tooltip" data-placement="top" title='{__("Copy")}'>
            <i class="fas fa-copy"></i>
          </button>
        </div>
      </div>
    </div>

    {if $system['social_share_enabled']}
      <div class="post-social-share">
        <a href="http://www.facebook.com/sharer.php?u={$system['system_url']}/posts/{$post['post_id']}" class="btn btn-sm btn-rounded btn-social-icon btn-facebook" target="_blank">
          <i class="fab fa-facebook-f"></i>
        </a>
        <a href="https://twitter.com/intent/tweet?url={$system['system_url']}/posts/{$post['post_id']}" class="btn btn-sm btn-rounded btn-social-icon btn-rounded btn-twitter" target="_blank">
          <i class="fab fa-twitter"></i>
        </a>
        <a href="https://vk.com/share.php?url={$system['system_url']}/posts/{$post['post_id']}" class="btn btn-sm btn-rounded btn-social-icon btn-vk" target="_blank">
          <i class="fab fa-vk"></i>
        </a>
        <a href="https://www.linkedin.com/shareArticle?mini=true&url={$system['system_url']}/posts/{$post['post_id']}" class="btn btn-sm btn-rounded btn-social-icon btn-linkedin" target="_blank">
          <i class="fab fa-linkedin"></i>
        </a>
        <a href="https://api.whatsapp.com/send?text={$system['system_url']}/posts/{$post['post_id']}" class="btn btn-sm btn-rounded btn-social-icon btn-whatsapp d-none d-sm-inline-block" target="_blank">
          <i class="fab fa-whatsapp"></i>
        </a>
        <a href="https://reddit.com/submit?url={$system['system_url']}/posts/{$post['post_id']}" class="btn btn-sm btn-rounded btn-social-icon btn-reddit" target="_blank">
          <i class="fab fa-reddit"></i>
        </a>
        <a href="https://pinterest.com/pin/create/button/?url={$system['system_url']}/posts/{$post['post_id']}" class="btn btn-sm btn-rounded btn-social-icon btn-pinterest" target="_blank">
          <i class="fab fa-pinterest"></i>
        </a>
      </div>
    {/if}

    <div class="h5 text-center">
      {__("Share the post to")}
    </div>

    <!-- share to options -->
    <div class="mb20 text-center">
      <!-- Timeline -->
      <input class="x-hidden input-label" type="radio" name="share_to" id="share_to_timeline" value="timeline" checked="checked" />
      <label class="button-label" for="share_to_timeline">
        <div class="icon">
          {include file='__svg_icons.tpl' icon="newsfeed" width="32px" height="32px"}
        </div>
        <div class="title">{__("Timeline")}</div>
      </label>
      <!-- Timeline -->
      <!-- Page -->
      {if $system['pages_enabled'] && $pages}
        <input class="x-hidden input-label" type="radio" name="share_to" id="share_to_page" value="page" />
        <label class="button-label" for="share_to_page">
          <div class="icon">
            {include file='__svg_icons.tpl' icon="pages" width="32px" height="32px"}
          </div>
          <div class="title">{__("Page")}</div>
        </label>
      {/if}
      <!-- Page -->
      <!-- Group -->
      {if $system['groups_enabled'] && $groups}
        <input class="x-hidden input-label" type="radio" name="share_to" id="share_to_group" value="group" />
        <label class="button-label" for="share_to_group">
          <div class="icon">
            {include file='__svg_icons.tpl' icon="groups" width="32px" height="32px"}
          </div>
          <div class="title">{__("Group")}</div>
        </label>
      {/if}
      <!-- Group -->
    </div>
    <!-- share to options -->

    <div id="js_share-to-page" class="x-hidden">
      <div class="form-group">
        <label class="form-control-label">{__("Select Page")}</label>
        <select name="page" class="form-control">
          {foreach $pages as $page}
            <option value="{$page['page_id']}">{$page['page_title']}</option>
          {/foreach}
        </select>
      </div>
    </div>

    <div id="js_share-to-group" class="x-hidden">
      <div class="form-group">
        <label class="form-control-label">{__("Select Groups")}</label>
        <select name="group" class="form-control">
          {foreach $groups as $group}
            <option value="{$group['group_id']}">{$group['group_title']}</option>
          {/foreach}
        </select>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12">
        <div class="form-group">
          <label class="form-control-label">{__("Message")}</label>
          <textarea name="message" rows="3" dir="auto" class="form-control"></textarea>
        </div>
      </div>
    </div>

    <!-- error -->
    <div class="alert alert-danger mb0 x-hidden"></div>
    <!-- error -->
  </div>
  <div class="modal-footer">
    <button type="submit" class="btn btn-primary">{__("Share")}</button>
  </div>
</form>

<script>
  /* share post */
  $('input[type=radio][name=share_to]').on('change', function() {
    switch ($(this).val()) {
      case 'timeline':
        $('#js_share-to-page').hide();
        $('#js_share-to-group').hide();
        break;
      case 'page':
        $('#js_share-to-page').fadeIn();
        $('#js_share-to-group').hide();
        break;
      case 'group':
        $('#js_share-to-page').hide();
        $('#js_share-to-group').fadeIn();
        break;
    }
  });
</script>