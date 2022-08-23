<li>
  <div class="conversation clearfix {if $message['user_id'] == $user->_data['user_id']}right{/if}" id="{$message['message_id']}">
    {if $message['user_id'] != $user->_data['user_id']}
      <div class="conversation-user">
        <a href="{$system['system_url']}/{$message['user_name']}">
          <img src="{$message['user_picture']}" alt="">
        </a>
      </div>
    {/if}
    <div class="conversation-body">
      <!-- message text -->
      <div class="text {if $message['user_id'] == $user->_data['user_id']}js_chat-color-me{/if}">
        {$message['message']}
        {if $message['image']}
          <span class="text-link js_lightbox-nodata {if $message['message'] != ''}mt5{/if}" data-image="{$system['system_uploads']}/{$message['image']}">
            <img alt="" class="img-fluid" src="{$system['system_uploads']}/{$message['image']}">
          </span>
        {/if}
        {if $message['voice_note']}
          <audio class="js_audio" id="audio-{$message['message_id']}" controls preload="auto" style="width: 100%; min-width: 120px;">
            <source src="{$system['system_uploads']}/{$message['voice_note']}" type="audio/mpeg">
            <source src="{$system['system_uploads']}/{$message['voice_note']}" type="audio/mp3">
            {__("Your browser does not support HTML5 audio")}
          </audio>
        {/if}
      </div>
      <!-- message text -->

      <!-- message time -->
      <div class="time js_moment" data-time="{$message['time']}">
        {$message['time']}
      </div>
      <!-- message time -->

      <!-- seen status -->
      {if $last_seen_message_id == $message['message_id']}
        <div class="seen">
          {__("Seen by")} {$conversation['seen_name_list']}
        </div>
      {/if}
      <!-- seen status -->
    </div>
  </div>
</li>