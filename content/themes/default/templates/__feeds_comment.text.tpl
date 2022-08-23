<div class="comment-replace">
  <div class="comment-text js_readmore" dir="auto">{$_comment['text']}</div>
  <div class="comment-text-plain x-hidden">{$_comment['text_plain']}</div>
  {if $_comment['image'] != ""}
    <span class="text-link js_lightbox-nodata" data-image="{$system['system_uploads']}/{$_comment['image']}">
      <img alt="" class="img-fluid" src="{$system['system_uploads']}/{$_comment['image']}">
    </span>
  {/if}
  {if $_comment['voice_note'] != ""}
    <audio class="js_audio" id="audio-{$_comment['comment_id']}" controls preload="auto" style="width: 100%; min-width: 200px;">
      <source src="{$system['system_uploads']}/{$_comment['voice_note']}" type="audio/mpeg">
      <source src="{$system['system_uploads']}/{$_comment['voice_note']}" type="audio/mp3">
      {__("Your browser does not support HTML5 audio")}
    </audio>
  {/if}
</div>