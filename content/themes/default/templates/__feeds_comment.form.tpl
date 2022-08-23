<div class="comment js_comment-form {if $post['comments_disabled']}x-hidden{/if}" data-handle="{$_handle}" data-id="{$_id}">
  <div class="comment-avatar">
    <a class="comment-avatar-picture" href="{$system['system_url']}/{$user->_data['user_name']}" style="background-image:url({$user->_data['user_picture']});">
    </a>
  </div>
  <div class="comment-data">
    <div class="x-form comment-form">
      <textarea dir="auto" class="js_autosize js_mention js_post-comment" rows="1" placeholder='{__("Write a comment")}'></textarea>
      <ul class="x-form-tools clearfix">
        <li class="x-form-tools-post js_post-comment">
          <i class="far fa-paper-plane fa-lg fa-fw"></i>
        </li>
        {if $system['comments_photos_enabled']}
          <li class="x-form-tools-attach">
            <i class="far fa-image fa-lg fa-fw js_x-uploader" data-handle="comment"></i>
          </li>
        {/if}
        {if $system['voice_notes_comments_enabled']}
          <li class="x-form-tools-voice js_comment-voice-notes-toggle">
            <i class="fas fa-microphone fa-lg fa-fw"></i>
          </li>
        {/if}
        <li class="x-form-tools-emoji js_emoji-menu-toggle">
          <i class="far fa-smile-wink fa-lg fa-fw"></i>
        </li>
      </ul>
    </div>
    <div class="comment-voice-notes">
      <div class="voice-recording-wrapper" data-handle="comment">
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
    <div class="comment-attachments attachments clearfix x-hidden">
      <ul>
        <li class="loading">
          <div class="progress x-progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</div>
<div class="pb10 text-center js_comment-disabled-msg {if !$post['comments_disabled']}x-hidden{/if}">
  {__("Commenting has been turned off for this post")}.
</div>