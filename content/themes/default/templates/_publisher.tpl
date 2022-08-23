<div class="publisher-overlay"></div>
<div class="x-form publisher" data-handle="{$_handle}" {if $_id}data-id="{$_id}" {/if}>

  <!-- publisher loader -->
  <div class="publisher-loader">
    <div class="loader loader_small"></div>
  </div>
  <!-- publisher loader -->

  <!-- publisher-message -->
  <div class="publisher-message">
    {if $_handle == "page"}
      <img class="publisher-avatar" src="{$spage['page_picture']}">
    {else}
      <img class="publisher-avatar" src="{$user->_data['user_picture']}">
    {/if}
    <div class="colored-text-wrapper">
      <textarea dir="auto" class="js_autosize js_mention js_publisher-scraper" data-init-placeholder='{__("What is on your mind? #Hashtag.. @Mention.. Link..")}' placeholder='{__("What is on your mind? #Hashtag.. @Mention.. Link..")}'>{if $page == "share" && $url}{$url}{/if}</textarea>
    </div>
    <div class="publisher-emojis">
      <div class="position-relative">
        <span class="js_emoji-menu-toggle" data-toggle="tooltip" data-placement="top" title='{__("Insert an emoji")}'>
          <i class="far fa-smile-wink fa-lg"></i>
        </span>
      </div>
    </div>
  </div>
  <!-- publisher-message -->

  <!-- publisher-slider -->
  <div class="publisher-slider">

    <!-- publisher scraper -->
    <div class="publisher-scraper"></div>
    <!-- publisher scraper -->

    <!-- post attachments -->
    <div class="publisher-attachments attachments clearfix x-hidden"></div>
    <!-- post attachments -->

    <!-- post album -->
    <div class="publisher-meta" data-meta="album">
      {include file='__svg_icons.tpl' icon="album" width="16px" height="16px"}
      <input type="text" placeholder='{__("Album title")}'>
    </div>
    <!-- post album -->

    <!-- post feelings -->
    <div class="publisher-meta" data-meta="feelings">
      <div id="feelings-menu-toggle" data-init-text='{__("What are you doing?")}'>{__("What are you doing?")}</div>
      <div id="feelings-data" style="display: none">
        <input type="text" class="no-icon" placeholder='{__("What are you doing?")}'>
        <span></span>
      </div>
      <div id="feelings-menu" class="dropdown-menu dropdown-widget">
        <div class="dropdown-widget-body ptb5">
          <div class="js_scroller">
            <ul class="feelings-list">
              {foreach $feelings as $feeling}
                <li class="feeling-item js_feelings-add" data-action="{$feeling['action']}" data-placeholder="{__($feeling['placeholder'])}">
                  <div class="icon">
                    <i class="twa twa-3x twa-{$feeling['icon']}"></i>
                  </div>
                  <div class="data">
                    {__($feeling['text'])}
                  </div>
                </li>
              {/foreach}
            </ul>
          </div>
        </div>
      </div>
      <div id="feelings-types" class="dropdown-menu dropdown-widget">
        <div class="dropdown-widget-body ptb5">
          <div class="js_scroller">
            <ul class="feelings-list">
              {foreach $feelings_types as $type}
                <li class="feeling-item js_feelings-type" data-type="{$type['action']}" data-icon="{$type['icon']}">
                  <div class="icon">
                    <i class="twa twa-3x twa-{$type['icon']}"></i>
                  </div>
                  <div class="data">
                    {__($type['text'])}
                  </div>
                </li>
              {/foreach}
            </ul>
          </div>
        </div>
      </div>
    </div>
    <!-- post feelings -->

    <!-- post location -->
    <div class="publisher-meta" data-meta="location">
      {include file='__svg_icons.tpl' icon="map" width="16px" height="16px"}
      <input class="js_geocomplete" type="text" placeholder='{__("Where are you?")}'>
    </div>
    <!-- post location -->

    <!-- post colored -->
    <div class="publisher-meta" data-meta="colored">
      {foreach $colored_patterns as $pattern}
        <div class="colored-pattern-item js_publisher-pattern" data-id="{$pattern['pattern_id']}" data-type="{$pattern['type']}" data-background-image="{$pattern['background_image']}" data-background-color-1="{$pattern['background_color_1']}" data-background-color-2="{$pattern['background_color_2']}" data-text-color="{$pattern['text_color']}" {if $pattern['type'] == "color"} style="background-image: linear-gradient(45deg, {$pattern['background_color_1']}, {$pattern['background_color_2']});" {else} style="background-image: url({$system['system_uploads']}/{$pattern['background_image']})" {/if}>
        </div>
      {/foreach}
    </div>
    <!-- post colored -->

    <!-- post voice notes -->
    <div class="publisher-meta" data-meta="voice_notes">
      <div class="voice-recording-wrapper" data-handle="publisher">
        <!-- processing message -->
        <div class="x-hidden js_voice-processing-message">
          {include file='__svg_icons.tpl' icon="upload" class="static mr5" width="16px" height="16px"}
          {__("Processing")}<span class="loading-dots"></span>
        </div>
        <!-- processing message -->

        <!-- success message -->
        <div class="x-hidden js_voice-success-message">
          {include file='__svg_icons.tpl' icon="checkmark" class="static mr5" width="16px" height="16px"}
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
    <!-- post voice notes -->

    <!-- post gif -->
    <div class="publisher-meta" data-meta="gif">
      {include file='__svg_icons.tpl' icon="gif" width="16px" height="16px"}
      <input class="js_publisher-gif-search" type="text" placeholder='{__("Search GIFs")}'>
    </div>
    <!-- post gif -->

    <!-- post poll -->
    <div class="publisher-meta" data-meta="poll">
      {include file='__svg_icons.tpl' icon="plus" width="16px" height="16px"}
      <input type="text" placeholder='{__("Add an option")}...'>
    </div>
    <div class="publisher-meta" data-meta="poll">
      {include file='__svg_icons.tpl' icon="plus" width="16px" height="16px"}
      <input type="text" placeholder='{__("Add an option")}...'>
    </div>
    <!-- post poll -->

    <!-- post video -->
    <div class="publisher-meta" data-meta="video">
      {include file='__svg_icons.tpl' icon="checkmark" class="static mr5" width="16px" height="16px"}
      {__("Video uploaded successfully")}
      <div class="float-right">
        <button type="button" class="close js_publisher-attachment-file-remover" data-type="video">
          <span>&times;</span>
        </button>
      </div>
    </div>
    <div class="publisher-custom-thumbnail">
      {__("Custom Video Thumbnail")}
      <div class="x-image">
        <button type="button" class="close x-hidden js_x-image-remover" title='{__("Remove")}'>
          <span>×</span>
        </button>
        <div class="x-image-loader">
          <div class="progress x-progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
          </div>
        </div>
        <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
        <input type="hidden" class="js_x-image-input" name="video_thumbnail" value="">
      </div>
    </div>
    <!-- post video -->

    <!-- post audio -->
    <div class="publisher-meta" data-meta="audio">
      {include file='__svg_icons.tpl' icon="checkmark" class="static mr5" width="16px" height="16px"}
      {__("Audio uploaded successfully")}
      <div class="float-right">
        <button type="button" class="close js_publisher-attachment-file-remover" data-type="audio">
          <span>&times;</span>
        </button>
      </div>
    </div>
    <!-- post audio -->

    <!-- post file -->
    <div class="publisher-meta" data-meta="file">
      {include file='__svg_icons.tpl' icon="checkmark" class="static mr5" width="16px" height="16px"}
      {__("File uploaded successfully")}
      <div class="float-right">
        <button type="button" class="close js_publisher-attachment-file-remover" data-type="file">
          <span>&times;</span>
        </button>
      </div>
    </div>
    <!-- post file -->

    <!-- publisher-tools-tabs -->
    <div class="publisher-tools-tabs">
      {if $_handle == "page" && ($system['offers_enabled'] || $system['jobs_enabled'])}
        <ul class="row">
          {if $system['offers_enabled']}
            <li class="col-md-6">
              <div class="publisher-tools-tab link js_publisher-tab" data-tab="offer" data-toggle="modal" data-url="posts/offer.php?do=create&page_id={$_id}">
                {include file='__svg_icons.tpl' icon="offers" class="mr5" width="24px" height="24px"}
                {__("Create Offer")}
              </div>
            </li>
          {/if}
          {if $system['jobs_enabled']}
            <li class="col-md-6">
              <div class="publisher-tools-tab link js_publisher-tab" data-tab="job" data-toggle="modal" data-url="posts/job.php?do=create&page_id={$_id}">
                {include file='__svg_icons.tpl' icon="jobs" class="mr5" width="24px" height="24px"}
                {__("Create Job")}
              </div>
            </li>
          {/if}
        </ul>
        <div class="divider"></div>
      {/if}
      <ul class="row">
        {if $user->_data['can_go_live']}
          <li class="col-md-6">
            <a class="publisher-tools-tab link js_publisher-tab" data-tab="live" href="{$system['system_url']}/live{if $_handle == "page"}?page_id={$_id}{/if}{if $_handle == "group"}?group_id={$_id}{/if}{if $_handle == "event"}?event_id={$_id}{/if}">
              {include file='__svg_icons.tpl' icon="live" class="mr5" width="24px" height="24px"}
              {__("Live Video")}
            </a>
          </li>
        {/if}
        {if $system['photos_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab attach js_publisher-tab" data-tab="photos">
              <img src="{$system['system_url']}/content/themes/{$system['theme']}/images/svg/camera.svg" class="js_x-uploader" data-handle="publisher" data-multiple="true">
              {__("Upload Photos")}
            </div>
          </li>
          <li class="col-md-6">
            <div class="publisher-tools-tab js_publisher-tab" data-tab="album">
              {include file='__svg_icons.tpl' icon="album" class="mr5" width="24px" height="24px"}
              {__("Create Album")}
            </div>
          </li>
        {/if}
        {if $system['activity_posts_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab js_publisher-feelings">
              {include file='__svg_icons.tpl' icon="smile" class="mr5" width="24px" height="24px"}
              {__("Feelings/Activity")}
            </div>
          </li>
        {/if}
        {if $system['geolocation_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab js_publisher-tab" data-tab="location">
              {include file='__svg_icons.tpl' icon="map" class="mr5" width="24px" height="24px"}
              {__("Check In")}
            </div>
          </li>
        {/if}
        {if $system['colored_posts_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab js_publisher-tab" data-tab="colored">
              {include file='__svg_icons.tpl' icon="posts_colored" class="mr5" width="24px" height="24px"}
              {__("Colored Posts")}
            </div>
          </li>
        {/if}
        {if $system['voice_notes_posts_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab js_publisher-tab" data-tab="voice_notes">
              {include file='__svg_icons.tpl' icon="voice_notes" class="mr5" width="24px" height="24px"}
              {__("Voice Notes")}
            </div>
          </li>
        {/if}
        {if $system['gif_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab js_publisher-tab" data-tab="gif">
              {include file='__svg_icons.tpl' icon="gif" class="mr5" width="24px" height="24px"}
              {__("GIF")}
            </div>
          </li>
        {/if}
        {if $user->_data['can_write_articles'] && $_handle != "page" && $_handle != "group" && $_handle != "event"}
          <li class="col-md-6">
            <a class="publisher-tools-tab link js_publisher-tab" data-tab="article" href="{$system['system_url']}/blogs/new">
              {include file='__svg_icons.tpl' icon="write_article" class="mr5" width="24px" height="24px"}
              {__("Write Article")}
            </a>
          </li>
        {/if}
        {if $user->_data['can_sell_products'] && $_handle != "page" && $_handle != "group" && $_handle != "event"}
          <li class="col-md-6">
            <div class="publisher-tools-tab link js_publisher-tab" data-tab="product" data-toggle="modal" data-url="posts/product.php?do=create">
              {include file='__svg_icons.tpl' icon="products" class="mr5" width="24px" height="24px"}
              {__("Sell Something")}
            </div>
          </li>
        {/if}
        {if $system['polls_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab js_publisher-tab" data-tab="poll">
              {include file='__svg_icons.tpl' icon="polls" class="mr5" width="24px" height="24px"}
              {__("Create Poll")}
            </div>
          </li>
        {/if}
        {if $system['videos_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab attach js_publisher-tab" data-tab="video">
              <img src="{$system['system_url']}/content/themes/{$system['theme']}/images/svg/video_camera.svg" class="js_x-uploader" data-handle="publisher" data-type="video">
              {__("Upload Video")}
            </div>
          </li>
        {/if}
        {if $system['audio_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab attach js_publisher-tab" data-tab="audio">
              <img src="{$system['system_url']}/content/themes/{$system['theme']}/images/svg/music_file.svg" class="js_x-uploader" data-handle="publisher" data-type="audio">
              {__("Upload Audio")}
            </div>
          </li>
        {/if}
        {if $system['file_enabled']}
          <li class="col-md-6">
            <div class="publisher-tools-tab attach js_publisher-tab" data-tab="file">
              <img src="{$system['system_url']}/content/themes/{$system['theme']}/images/svg/folder.svg" class="js_x-uploader" data-handle="publisher" data-type="file">
              {__("Upload File")}
            </div>
          </li>
        {/if}
      </ul>
    </div>
    <!-- publisher-tools-tabs -->

    <!-- publisher-footer -->
    <div class="publisher-footer">
      {if $system['anonymous_mode'] && $_handle == "me"}
        <div class="float-left">
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input js_publisher-anonymous-toggle" name="is_anonymous" id="is_anonymous">
            <label class="custom-control-label" for="is_anonymous">
              <span class="publisher-anonymous-lable"><i class="fa fa-user-secret fa-fw mr5"></i>{__("Post As Anonymous")}</span>
            </label>
          </div>
        </div>
      {/if}
      <!-- publisher-buttons -->
      {if $_privacy}
        {if $system['newsfeed_source'] == "default"}
          <!-- privacy -->
          {if $system['default_privacy'] == "me"}
            <div class="btn-group js_publisher-privacy" data-toggle="tooltip" data-placement="top" data-value="me" title='{__("Shared with: Only Me")}'>
              <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown" data-display="static">
                <i class="btn-group-icon fa fa-lock mr10"></i><span class="btn-group-text">{__("Only Me")}</span>
              </button>
            {elseif $system['default_privacy'] == "friends"}
              <div class="btn-group js_publisher-privacy" data-toggle="tooltip" data-placement="top" data-value="friends" title='{__("Shared with: Friends")}'>
                <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown" data-display="static">
                  <i class="btn-group-icon fa fa-users mr10"></i><span class="btn-group-text">{__("Friends")}</span>
                </button>
              {else}
                <div class="btn-group js_publisher-privacy" data-toggle="tooltip" data-placement="top" data-value="public" title='{__("Shared with: Public")}'>
                  <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown" data-display="static">
                    <i class="btn-group-icon fa fa-globe mr10"></i><span class="btn-group-text">{__("Public")}</span>
                  </button>
                {/if}
                <div class="dropdown-menu dropdown-menu-right">
                  <div class="dropdown-item pointer" data-title='{__("Shared with: Public")}' data-value="public">
                    <i class="fa fa-globe mr5"></i>{__("Public")}
                  </div>
                  <div class="dropdown-item pointer" data-title='{__("Shared with: Friends")}' data-value="friends">
                    <i class="fa fa-users mr5"></i>{__("Friends")}
                  </div>
                  {if $_handle == 'me'}
                    <div class="dropdown-item pointer" data-title='{__("Shared with: Only Me")}' data-value="me">
                      <i class="fa fa-lock mr5"></i>{__("Only Me")}
                    </div>
                  {/if}
                </div>
              </div>
              {if $system['anonymous_mode'] && $_handle == "me"}
                <button disabled="disabled" type="button" class="btn btn-sm btn-light x-hidden js_publisher-privacy-public" data-toggle="tooltip" title='{__("Shared with: Public")}'>
                  <i class="btn-group-icon fa fa-globe mr10"></i><span class="btn-group-text">{__("Public")}</span>
                </button>
              {/if}
              <!-- privacy -->
            {/if}
          {/if}
          <button type="button" class="btn btn-sm btn-primary ml5 js_publisher-btn js_publisher">{__("Post")}</button>
          <!-- publisher-buttons -->
        </div>
        <!-- publisher-footer -->
      </div>
      <!-- publisher-slider -->
</div>