<ul>
  {foreach $sidebar_friends as $_user}
    <li class="feeds-item">
      <div class="data-container clickable small js_chat-start" data-uid="{$_user['user_id']}" data-name="{if $system['show_usernames_enabled']}{$_user['user_name']}{else}{$_user['user_firstname']} {$_user['user_lastname']}{/if}" data-link="{$_user['user_name']}">
        <div class="data-avatar">
          <img src="{$_user['user_picture']}" alt="">
        </div>
        <div class="data-content">
          <div class="float-right">
            <i class="fa fa-circle {if $_user['user_is_online'] }online{else}offline{/if}"></i>
          </div>
          <div>
            <strong>
              {if $system['show_usernames_enabled']}{$_user['user_name']}{else}{$_user['user_firstname']} {$_user['user_lastname']}{/if}
            </strong>
            {if $system['chat_status_enabled'] && !$_user['user_is_online']}
              <br>
              <small>
                {{__("Last Seen")}} <span class="js_moment" data-time="{$_user['user_last_seen']}">{$_user['user_last_seen']}</span>
              </small>
            {/if}
          </div>
        </div>
      </div>
    </li>
  {/foreach}
</ul>