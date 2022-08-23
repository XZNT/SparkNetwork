<li>
  <div class="comment {if $_is_reply}reply{/if}" data-id="{$_comment['comment_id']}" id="comment_{$_comment['comment_id']}">
    <!-- comment avatar -->
    <div class="comment-avatar">
      <a class="comment-avatar-picture" href="{$_comment['author_url']}" style="background-image:url({$_comment['author_picture']});">
      </a>
    </div>
    <!-- comment avatar -->

    <!-- comment body -->
    <div class="comment-data">
      <!-- comment menu -->
      {if $user->_logged_in}
        <div class="comment-btn dropdown">
          <i class="fas fa-ellipsis-h dropdown-toggle-icon" data-toggle="dropdown" data-display="static"></i>
          <div class="dropdown-menu dropdown-menu-right">
            {if !$_comment['edit_comment'] && !$_comment['delete_comment'] }
              <div class="dropdown-item pointer" data-toggle="modal" data-url="data/report.php?do=create&handle=comment&id={$_comment['comment_id']}">{__("Report")}</div>
            {elseif !$_comment['edit_comment'] && $_comment['delete_comment']}
              <div class="dropdown-item pointer js_delete-comment">{__("Delete Comment")}</div>
            {else}
              <div class="dropdown-item pointer js_edit-comment">{__("Edit Comment")}</div>
              <div class="dropdown-item pointer js_delete-comment">{__("Delete Comment")}</div>
            {/if}
          </div>
        </div>
      {/if}
      <!-- comment menu -->

      <!-- comment author & text  -->
      <div class="comment-inner-wrapper">
        <div class="comment-inner js_notifier-flasher">
          <!-- author -->
          <div class="comment-author">
            <span class="js_user-popover" data-type="{$_comment['user_type']}" data-uid="{$_comment['user_id']}">
              <a href="{$_comment['author_url']}">{$_comment['author_name']}</a>
            </span>
            {if $_comment['author_verified']}
              <i data-toggle="tooltip" data-placement="top" title='{__("Verified User")}' class="fa fa-check-circle fa-fw verified-badge"></i>
            {/if}
          </div>
          <!-- author -->

          <!-- text -->
          {include file='__feeds_comment.text.tpl'}
          <!-- text -->
        </div>
      </div>
      <!-- comment author & text  -->

      <!-- comment actions & time  -->
      <ul class="comment-actions clearfix">
        <!-- reactions -->
        <li>
          <div class="pointer unselectable reactions-wrapper {if $_comment['i_react']}js_unreact-comment{/if}" data-reaction="{$_comment['i_reaction']}">
            <!-- reaction-btn -->
            <div class="reaction-btn">
              {if !$_comment['i_react']}
                <div class="reaction-btn-icon d-none">
                  <i class="fa fa-thumbs-up fa-fw"></i>
                </div>
                <span class="reaction-btn-name text-link">{__("Like")}</span>
              {else}
                <div class="reaction-btn-icon d-none">
                  <div class="inline-emoji no_animation">
                    {include file='__reaction_emojis.tpl' _reaction=$_comment['i_reaction']}
                  </div>
                </div>
                <span class="reaction-btn-name text-link {$_comment['i_reaction_details']['color']}">{$_comment['i_reaction_details']['title']}</span>
              {/if}
            </div>
            <!-- reaction-btn -->

            <!-- reactions-container -->
            <div class="reactions-container">
              {foreach $reactions as $reaction}
                <div class="reactions_item duration-{$reaction@iteration} js_react-comment" data-reaction="{$reaction['reaction']}" data-reaction-color="{$reaction['color']}" data-title="{$reaction['title']}">
                  {include file='__reaction_emojis.tpl' _reaction=$reaction['reaction']}
                </div>
              {/foreach}
            </div>
            <!-- reactions-container -->
          </div>
        </li>
        <!-- reactions -->

        <!-- comment -->
        <li>
          <span class="text-link js_reply {if $_comment['comments_disabled']}x-hidden{/if}" data-username="{if $user->_data['user_name'] != $_comment['author_user_name']}{$_comment['author_user_name']}{/if}">
            {__("Reply")}
          </span>
        </li>
        <!-- comment -->

        <!-- time  -->
        <li>
          <small class="text-muted js_moment" data-time="{$_comment['time']}">{$_comment['time']}</small>
        </li>
        <!-- time  -->

        <!-- reactions stats -->
        {if $_comment['reactions_total_count'] > 0}
          <li class="ml5">
            <div data-toggle="modal" data-url="posts/who_reacts.php?comment_id={$_comment['comment_id']}">
              <div class="reactions-stats">
                {foreach $_comment['reactions'] as $reaction_type => $reaction_count}
                  {if $reaction_count > 0}
                    <div class="reactions-stats-item">
                      <div class="inline-emoji no_animation">
                        {include file='__reaction_emojis.tpl' _reaction=$reaction_type}
                      </div>
                    </div>
                  {/if}
                {/foreach}
                <!-- reactions count -->
                <span>
                  {$_comment['reactions_total_count']}
                </span>
                <!-- reactions count -->
              </div>
            </div>
          </li>
        {/if}
        <!-- reactions stats -->
      </ul>
      <!-- comment actions & time  -->

      <!-- comment replies  -->
      {if !$_is_reply}
        {if !$standalone && $_comment['replies'] > 0}
          <div class="ptb10 plr10 js_replies-toggle">
            <span class="text-link">
              <i class="fa fa-comments"></i>
              {$_comment['replies']} {__("Replies")}
            </span>
          </div>
        {/if}
        <div class="comment-replies {if !$standalone}x-hidden{/if}">
          <!-- previous replies -->
          {if $_comment['replies'] >= $system['min_results']}
            <div class="pb10 text-center js_see-more" data-get="comment_replies" data-id="{$_comment['comment_id']}" data-remove="true">
              <span class="text-link">
                <i class="fa fa-comment"></i>
                {__("View previous replies")}
              </span>
              <div class="loader loader_small x-hidden"></div>
            </div>
          {/if}
          <!-- previous replies -->

          <!-- replies -->
          <ul class="js_replies">
            {if $_comment['replies'] > 0}
              {foreach $_comment['comment_replies'] as $reply}
                {include file='__feeds_comment.tpl' _comment=$reply _is_reply=true}
              {/foreach}
            {/if}
          </ul>
          <!-- replies -->

          <!-- post a reply -->
          {if $user->_logged_in}
            <div class="x-hidden js_reply-form">
              <div class="x-form comment-form">
                <textarea dir="auto" class="js_autosize js_mention js_post-reply" rows="1" placeholder='{__("Write a Reply")}'></textarea>
                <ul class="x-form-tools clearfix">
                  <li class="x-form-tools-post js_post-reply">
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
          {/if}
          <!-- post a reply -->
        </div>
      {/if}
      <!-- comment replies  -->
    </div>
    <!-- comment body -->
  </div>
</li>