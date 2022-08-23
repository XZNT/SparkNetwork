{if $_get}
  {if $posts}
    <ul>
      {foreach $posts as $post}
        {include file='__feeds_post.tpl'}
      {/foreach}
    </ul>

    <!-- see-more -->
    <div class="alert alert-post see-more mb20 js_see-more {if $user->_logged_in}js_see-more-infinite{/if}" data-get="{$_get}" data-filter="{$_filter}" {if $_id}data-id="{$_id}" {/if}>
      <span>{__("More Stories")}</span>
      <div class="loader loader_small x-hidden"></div>
    </div>
    <!-- see-more -->
  {else}
    {include file='_no_data.tpl'}
  {/if}
{else}
  {foreach $posts as $post}
    {include file='__feeds_post.tpl'}
  {/foreach}
{/if}