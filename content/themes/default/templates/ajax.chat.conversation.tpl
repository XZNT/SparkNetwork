<div class="card panel-messages" data-cid="{$conversation['conversation_id']}" data-color="{$conversation['color']}">
  <div class="card-header with-icon pb10 bg-transparent">
    <div class="float-right">
      {if !$conversation['multiple_recipients']}
        {if $system['video_call_enabled']}
          <button type="button" class="btn btn-icon btn-rounded btn-success js_chat-call-start" data-type="video" data-uid="{$conversation['user_id']}" data-name="{$conversation['name']}">
            <i class="fa fa-video fa-lg fa-fw"></i>
          </button>
        {/if}
        {if $system['audio_call_enabled']}
          <button type="button" class="btn btn-icon btn-rounded btn-info js_chat-call-start" data-type="audio" data-uid="{$conversation['user_id']}" data-name="{$conversation['name']}">
            <i class="fa fa-phone-alt fa-lg fa-fw"></i>
          </button>
        {/if}
      {/if}
      <button type="button" class="btn btn-sm btn-danger rounded-pill js_delete-conversation">
        {__("Delete")}
      </button>
    </div>
    {if !$conversation['multiple_recipients']}
      {$conversation['name_html']}
    {else}
      <span title="{$conversation['name_list']}">{$conversation['name']}</span>
    {/if}
  </div>
  <div class="card-body">
    <div class="chat-conversations js_scroller" data-slimScroll-height="440px" data-slimScroll-start="bottom">
      {include file='ajax.chat.conversation.messages.tpl'}
    </div>
    <div class="chat-typing">
      <i class="far fa-comment-dots mr5"></i><span class="loading-dots"><span class="js_chat-typing-users"></span> {__("Typing")}</span>
    </div>
    <div class="chat-voice-notes">
      <div class="voice-recording-wrapper" data-handle="chat">
        <!-- processing message -->
        <div class="x-hidden js_voice-processing-message">
          {include file='__svg_icons.tpl' icon="upload" class="mr5" width="16px" height="16px"}
          {__("Processing")}<span class="loading-dots"></span>
        </div>
        <!-- processing message -->

        <!-- success message -->
        <div class="x-hidden js_voice-success-message">
          {include file='__svg_icons.tpl' icon="checkmark" class="mr5" width="16px" height="16px"}
          {__("Voice note recorded successfully")}
          <div class="float-right">
            <button type="button" class="close js_voice-remove">
              <span>&times;</span>
            </button>
          </div>
        </div>
        <!-- success message -->

        <!-- start recording -->
        <div class="btn-voice-start js_voice-start">
          <i class="fas fa-microphone mr5"></i>{__("Record")}
        </div>
        <!-- start recording -->

        <!-- stop recording -->
        <div class="btn-voice-stop js_voice-stop" style="display: none">
          <i class="far fa-stop-circle mr5"></i>{__("Recording")} <span class="js_voice-timer">00:00</span>
        </div>
        <!-- stop recording -->
      </div>
    </div>
    <div class="chat-attachments attachments clearfix x-hidden">
      <ul>
        <li class="loading">
          <div class="progress x-progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </li>
      </ul>
    </div>
    <div class="x-form chat-form">
      <div class="chat-form-message">
        <textarea class="js_autosize js_post-message" dir="auto" rows="1" placeholder='{__("Write a message")}'></textarea>
      </div>
      <ul class="x-form-tools clearfix">
        {if $system['chat_photos_enabled']}
          <li class="x-form-tools-attach">
            <i class="far fa-image fa-lg fa-fw js_x-uploader" data-handle="chat"></i>
          </li>
        {/if}
        {if $system['voice_notes_chat_enabled']}
          <li class="x-form-tools-voice js_chat-voice-notes-toggle">
            <i class="fas fa-microphone fa-lg fa-fw"></i>
          </li>
        {/if}
        <li class="x-form-tools-emoji js_emoji-menu-toggle">
          <i class="far fa-smile-wink fa-lg fa-fw"></i>
        </li>
        <li class="x-form-tools-colors js_chat-colors-menu-toggle js_chat-color-me">
          <i class="fa fa-circle fa-lg fa-fw"></i>
        </li>
        <li class="x-form-tools-post js_post-message">
          <i class="far fa-paper-plane fa-lg fa-fw"></i>
        </li>
      </ul>
    </div>
  </div>
</div>