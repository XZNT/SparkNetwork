<!-- post header -->
<div class="post-header">
  <!-- post picture -->
  <div class="post-avatar">
    {if $_post['is_anonymous']}
      <div class="post-avatar-anonymous">
        {include file='__svg_icons.tpl' icon="spy" width="30px" height="30px"}
      </div>
    {else}
      <a class="post-avatar-picture" href="{$_post['post_author_url']}" style="background-image:url({$_post['post_author_picture']});">
      </a>
      {if $_post['post_author_online']}<i class="fa fa-circle online-dot"></i>{/if}
    {/if}
  </div>
  <!-- post picture -->

  <!-- post meta -->
  <div class="post-meta">
    <!-- post menu -->
    {if !$_shared && $user->_logged_in && $_get != "posts_information"}
      <div class="float-right dropdown">
        <i class="fa fa-chevron-down dropdown-toggle" data-toggle="dropdown" data-display="static"></i>
        <div class="dropdown-menu dropdown-menu-right post-dropdown-menu">
          {if $_post['manage_post'] && $_post['post_type'] == "product"}
            {if $_post['product']['available']}
              <div class="dropdown-item pointer js_sold-post">
                <div class="action no-desc">
                  <i class="fa fa-shopping-cart fa-fw"></i> <span>{__("Mark as Sold")}</span>
                </div>
              </div>
            {else}
              <div class="dropdown-item pointer js_unsold-post">
                <div class="action no-desc">
                  <i class="fa fa-shopping-cart fa-fw"></i> <span>{__("Mark as Available")}</span>
                </div>
              </div>
            {/if}
            <div class="dropdown-divider"></div>
          {/if}
          {if $_post['manage_post'] && $_post['post_type'] == "job"}
            {if $_post['job']['available']}
              <div class="dropdown-item pointer js_closed-post">
                <div class="action no-desc">
                  <i class="fa fa-briefcase fa-fw"></i> <span>{__("Mark as Closed")}</span>
                </div>
              </div>
            {else}
              <div class="dropdown-item pointer js_unclosed-post">
                <div class="action no-desc">
                  <i class="fa fa-briefcase fa-fw"></i> <span>{__("Mark as Available")}</span>
                </div>
              </div>
            {/if}
            <div class="dropdown-divider"></div>
          {/if}
          {if $_post['i_save']}
            <div href="#" class="dropdown-item pointer js_unsave-post">
              <div class="action no-desc">
                <i class="fa fa-bookmark fa-fw"></i> <span>{__("Unsave Post")}</span>
              </div>
            </div>
          {else}
            <div class="dropdown-item pointer js_save-post">
              <div class="action no-desc">
                <i class="fa fa-bookmark fa-fw"></i> <span>{__("Save Post")}</span>
              </div>
            </div>
          {/if}
          <div class="dropdown-divider"></div>
          {if $_post['manage_post']}
            <!-- Boost -->
            {if $system['packages_enabled'] && !$_post['in_group'] && !$_post['in_event']}
              {if $_post['boosted']}
                <div class="dropdown-item pointer js_unboost-post">
                  <div class="action no-desc">
                    <i class="fa fa-bolt fa-fw"></i> <span>{__("Unboost Post")}</span>
                  </div>
                </div>
              {else}
                {if $user->_data['can_boost_posts']}
                  <div class="dropdown-item pointer js_boost-post">
                    <div class="action no-desc">
                      <i class="fa fa-bolt fa-fw"></i> <span>{__("Boost Post")}</span>
                    </div>
                  </div>
                {else}
                  <a href="{$system['system_url']}/packages" class="dropdown-item">
                    <div class="action no-desc">
                      <i class="fa fa-bolt fa-fw"></i> <span>{__("Boost Post")}</span>
                    </div>
                  </a>
                {/if}
              {/if}
            {/if}
            <!-- Boost -->
            <!-- Pin -->
            {if !$_post['is_anonymous']}
              {if (!$_post['in_group'] && !$_post['in_event']) || ($_post['in_group'] && $_post['is_group_admin']) || ($_post['in_event'] && $_post['is_event_admin'])}
                {if $_post['pinned']}
                  <div class="dropdown-item pointer js_unpin-post">
                    <div class="action no-desc">
                      <i class="fa fa-thumbtack fa-fw"></i> <span>{__("Unpin Post")}</span>
                    </div>
                  </div>
                {else}
                  <div class="dropdown-item pointer js_pin-post">
                    <div class="action no-desc">
                      <i class="fa fa-thumbtack fa-fw"></i> <span>{__("Pin Post")}</span>
                    </div>
                  </div>
                {/if}
              {/if}
            {/if}
            <!-- Pin -->
            <!-- Edit -->
            {if $_post['post_type'] == "article"}
              <a href="{$system['system_url']}/blogs/edit/{$_post['post_id']}" class="dropdown-item pointer">
                <div class="action no-desc">
                  <i class="fa fa-pencil-alt fa-fw"></i> {__("Edit Article")}
                </div>
              </a>
            {elseif $_post['post_type'] == "product"}
              <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/product.php?do=edit&post_id={$_post['post_id']}">
                <div class="action no-desc">
                  <i class="fa fa-pencil-alt fa-fw"></i> {__("Edit Product")}
                </div>
              </div>
            {elseif $_post['post_type'] == "funding"}
              <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/funding.php?do=edit&post_id={$_post['post_id']}">
                <div class="action no-desc">
                  <i class="fa fa-pencil-alt fa-fw"></i> {__("Edit Funding")}
                </div>
              </div>
            {elseif $_post['post_type'] == "offer"}
              <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/offer.php?do=edit&post_id={$_post['post_id']}">
                <div class="action no-desc">
                  <i class="fa fa-pencil-alt fa-fw"></i> {__("Edit Offer")}
                </div>
              </div>
            {elseif $_post['post_type'] == "job"}
              <div class="dropdown-item pointer" data-toggle="modal" data-url="posts/job.php?do=edit&post_id={$_post['post_id']}">
                <div class="action no-desc">
                  <i class="fa fa-pencil-alt fa-fw"></i> {__("Edit Job")}
                </div>
              </div>
            {else}
              <div class="dropdown-item pointer js_edit-post">
                <div class="action no-desc">
                  <i class="fa fa-pencil-alt fa-fw"></i> {__("Edit Post")}
                </div>
              </div>
            {/if}
            <!-- Edit -->
            <!-- Delete -->
            <div class="dropdown-item pointer js_delete-post">
              <div class="action no-desc">
                <i class="fa fa-trash-alt fa-fw"></i> {__("Delete Post")}
              </div>
            </div>
            <!-- Delete -->
            <!-- Hide -->
            {if $_post['user_type'] == "user" && !$_post['in_group'] && !$_post['in_event'] && !$_post['is_anonymous']}
              {if $_post['is_hidden']}
                <div class="dropdown-item pointer js_allow-post">
                  <div class="action no-desc">
                    <i class="fa fa-eye fa-fw"></i> <span>{__("Allow on Timeline")}</span>
                  </div>
                </div>
              {else}
                <div class="dropdown-item pointer js_disallow-post">
                  <div class="action no-desc">
                    <i class="fa fa-eye-slash fa-fw"></i> <span>{__("Hide from Timeline")}</span>
                  </div>
                </div>
              {/if}
            {/if}
            <!-- Hide -->
            <!-- Disable Comments -->
            {if $_post['comments_disabled']}
              <div class="dropdown-item pointer js_enable-post-comments">
                <div class="action no-desc">
                  <i class="fa fa-comment fa-fw"></i> <span>{__("Turn on Commenting")}</span>
                </div>
              </div>
            {else}
              <div class="dropdown-item pointer js_disable-post-comments">
                <div class="action no-desc">
                  <i class="fa fa-comment-slash fa-fw"></i> <span>{__("Turn off Commenting")}</span>
                </div>
              </div>
            {/if}
            <!-- Disable Comments -->
          {else}
            {if $_post['user_type'] == "user" && !$_post['is_anonymous']}
              <div class="dropdown-item pointer js_hide-author" data-author-id="{$_post['user_id']}" data-author-name="{$_post['post_author_name']}">
                <div class="action">
                  <i class="fa fa-minus-circle fa-fw"></i> {__("Unfollow")} {if $system['show_usernames_enabled']}{$_post['user_name']}{else}{$_post['user_firstname']}{/if}
                </div>
                <div class="action-desc">{__("Stop seeing posts but stay friends")}</div>
              </div>
            {/if}
            <div class="dropdown-item pointer js_hide-post">
              <div class="action">
                <i class="fa fa-eye-slash fa-fw"></i> {__("Hide this post")}
              </div>
              <div class="action-desc">{__("See fewer posts like this")}</div>
            </div>
            <div class="dropdown-item pointer" data-toggle="modal" data-url="data/report.php?do=create&handle=post&id={$_post['post_id']}">
              <div class="action no-desc">
                <i class="fa fa-flag fa-fw"></i> {__("Report post")}
              </div>
            </div>
          {/if}
          <div class="dropdown-divider"></div>
          <a href="{$system['system_url']}/posts/{$_post['post_id']}" target="_blank" class="dropdown-item">
            <div class="action no-desc">
              <i class="fa fa-link fa-fw"></i> {__("Open post in new tab")}
            </div>
          </a>
          {if $_post['is_anonymous'] && ($user->_is_admin || $user->_is_moderator)}
            <div class="dropdown-divider"></div>
            <a href="{$_post['post_author_url']}" target="_blank" class="dropdown-item">
              <div class="action no-desc">
                <i class="fa fa-user-secret fa-fw"></i> {__("Open Author Profile")}
              </div>
            </a>
          {/if}
        </div>
      </div>
    {/if}
    <!-- post menu -->

    <!-- post author -->
    {if $_post['is_anonymous']}
      <span class="post-author">{__("Anonymous")}</span>
    {else}
      <span class="js_user-popover" data-type="{$_post['user_type']}" data-uid="{$_post['user_id']}">
        <a class="post-author" href="{$_post['post_author_url']}">{$_post['post_author_name']}</a>
      </span>
      {if $_post['post_author_verified']}
        {if $_post['user_type'] == "user"}
          <i data-toggle="tooltip" data-placement="top" title='{__("Verified User")}' class="fa fa-check-circle fa-fw verified-badge"></i>
        {else}
          <i data-toggle="tooltip" data-placement="top" title='{__("Verified Page")}' class="fa fa-check-circle fa-fw verified-badge"></i>
        {/if}
      {/if}
      {if $_post['user_subscribed']}
        <i data-toggle="tooltip" data-placement="top" title='{__($_post['package_name'])} {__('Member')}' class="fa fa-bolt fa-fw pro-badge"></i>
      {/if}
    {/if}
    <!-- post author -->

    <!-- post-title -->
    <span class="post-title">
      {if !$_shared && $_post['post_type'] == "shared"}
        {__("shared")}
        {if $_post['origin']['is_anonymous']}
          {__("Anonymous post")}
        {else}
          <span class="js_user-popover" data-type="{$_post['origin']['user_type']}" data-uid="{$_post['origin']['user_id']}">
            <a href="{$_post['origin']['post_author_url']}">
              {$_post['origin']['post_author_name']}
            </a>{__("'s")}
          </span>
          <a href="{$system['system_url']}/posts/{$_post['origin']['post_id']}">
            {if $_post['origin']['post_type'] == 'link'}
              {__("link")}

            {elseif $_post['origin']['post_type'] == 'media'}
              {if $_post['origin']['media']['media_type'] != "soundcloud"}
                {__("video")}
              {else}
                {__("song")}
              {/if}

            {elseif $_post['origin']['post_type'] == 'photos'}
              {if $_post['origin']['photos_num'] > 1}{__("photos")}{else}{__("photo")}{/if}

            {elseif $_post['origin']['post_type'] == 'album'}
              {__("album")}

            {elseif $_post['origin']['post_type'] == 'poll'}
              {__("poll")}

            {elseif $_post['origin']['post_type'] == 'video'}
              {__("video")}

            {elseif $_post['origin']['post_type'] == 'audio'}
              {__("audio")}

            {elseif $_post['origin']['post_type'] == 'file'}
              {__("file")}

            {else}
              {__("post")}
            {/if}
          </a>
        {/if}

      {elseif $_post['post_type'] == "link"}
        {__("shared a link")}

      {elseif $_post['post_type'] == "live"}
        {if $_post['live']['live_ended']}
          {__("was live")}
        {else}
          {__("is live now")}
        {/if}

      {elseif $_post['post_type'] == "photos"}
        {if $_post['photos_num'] == 1}
          {__("added a photo")}
        {else}
          {__("added")} {$_post['photos_num']} {__("photos")}
        {/if}

      {elseif $_post['post_type'] == "album"}
        {__("added")} {$_post['photos_num']} {__("photos to the album")}: <a href="{$system['system_url']}/{$_post['album']['path']}/album/{$_post['album']['album_id']}">{$_post['album']['title']}</a>

      {elseif $_post['post_type'] == "profile_picture"}
        {__("updated the profile picture")}

      {elseif $_post['post_type'] == "profile_cover"}
        {__("updated the cover photo")}

      {elseif $_post['post_type'] == "page_picture"}
        {__("updated page picture")}

      {elseif $_post['post_type'] == "page_cover"}
        {__("updated cover photo")}

      {elseif $_post['post_type'] == "group_picture"}
        {__("updated group picture")}

      {elseif $_post['post_type'] == "group_cover"}
        {__("updated group cover")}

      {elseif $_post['post_type'] == "event_cover"}
        {__("updated event cover")}

      {elseif $_post['post_type'] == "article"}
        {__("added new article")}

      {elseif $_post['post_type'] == "product"}
        {__("added new product for sale")}

      {elseif $_post['post_type'] == "funding"}
        {__("raised new funding request")}

      {elseif $_post['post_type'] == "offer"}
        {__("added new offer")}

      {elseif $_post['post_type'] == "job"}
        {__("added new job")}

      {elseif $_post['post_type'] == "poll"}
        {__("added a poll")}

      {elseif $_post['post_type'] == "video"}
        {__("added a video")}

      {elseif $_post['post_type'] == "audio"}
        {__("added an audio")}

      {elseif $_post['post_type'] == "file"}
        {__("added a file")}

      {/if}

      {if $_get != 'posts_group' && $_post['in_group']}
        <i class="fa fa-caret-right ml5 mr5"></i><i class="fa fa-users ml5 mr5"></i><a href="{$system['system_url']}/groups/{$_post['group_name']}">{$_post['group_title']}</a>

      {elseif $_get != 'posts_event' && $_post['in_event']}
        <i class="fa fa-caret-right ml5 mr5"></i><i class="fa fa-calendar ml5 mr5"></i><a href="{$system['system_url']}/events/{$_post['event_id']}">{$_post['event_title']}</a>

      {elseif $_post['in_wall']}
        <i class="fa fa-caret-right ml5 mr5"></i>
        <span class="js_user-popover" data-type="user" data-uid="{$_post['wall_id']}">
          <a href="{$system['system_url']}/{$_post['wall_username']}">{$_post['wall_fullname']}</a>
        </span>
      {/if}
    </span>
    <!-- post-title -->

    <!-- post feeling -->
    {if $_post['feeling_action']}
      <span class="post-title">
        {if $_post['post_type'] != "" && $_post['post_type'] != "map"} & {/if}{__("is")} {__($_post["feeling_action"])} {__($_post["feeling_value"])} <i class="twa twa-lg twa-{$_post['feeling_icon']}"></i>
      </span>
    {/if}
    <!-- post feeling -->

    <!-- post time & location & privacy -->
    <div class="post-time">
      <a href="{$system['system_url']}/posts/{$_post['post_id']}" class="js_moment" data-time="{$_post['time']}">{$_post['time']}</a>
      {if $_post['location']}
        - <i class="fa fa-map-marker"></i> <span>{$_post['location']}</span>
      {/if}
      {if $system['post_translation_enabled']}
        - <span class="text-link js_translator">{__("Translate")}</span>
      {/if}
      {if $system['newsfeed_source'] == "default"}
        -
        {if !$_post['is_anonymous'] && !$_shared && $_post['manage_post'] && $_post['user_type'] == 'user' && !$_post['in_group'] && !$_post['in_event'] && $_post['post_type'] != "article" && $_post['post_type'] != "product" && $_post['post_type'] != "funding"}
          <!-- privacy -->
          {if $_post['privacy'] == "me"}
            <div class="btn-group" data-toggle="tooltip" data-placement="top" data-value="me" title='{__("Shared with: Only Me")}'>
              <button type="button" class="btn dropdown-toggle" data-toggle="dropdown" data-display="static">
                <i class="btn-group-icon fa fa-lock"></i>
              </button>
            {elseif $_post['privacy'] == "friends"}
              <div class="btn-group" data-toggle="tooltip" data-placement="top" data-value="friends" title='{__("Shared with: Friends")}'>
                <button type="button" class="btn dropdown-toggle" data-toggle="dropdown" data-display="static">
                  <i class="btn-group-icon fa fa-users"></i>
                </button>
              {elseif $_post['privacy'] == "public"}
                <div class="btn-group" data-toggle="tooltip" data-placement="top" data-value="public" title='{__("Shared with: Public")}'>
                  <button type="button" class="btn dropdown-toggle" data-toggle="dropdown" data-display="static">
                    <i class="btn-group-icon fa fa-globe"></i>
                  </button>
                {/if}
                <div class="dropdown-menu dropdown-menu-left">
                  <div class="dropdown-item pointer js_edit-privacy" data-title='{__("Shared with: Public")}' data-value="public">
                    <i class="fa fa-globe"></i> {__("Public")}
                  </div>
                  <div class="dropdown-item pointer js_edit-privacy" data-title='{__("Shared with: Friends")}' data-value="friends">
                    <i class="fa fa-users"></i> {__("Friends")}
                  </div>
                  <div class="dropdown-item pointer js_edit-privacy" data-title='{__("Shared with: Only Me")}' data-value="me">
                    <i class="fa fa-lock"></i> {__("Only Me")}
                  </div>
                </div>
              </div>
              <!-- privacy -->
            {else}
              {if $_post['privacy'] == "me"}
                <i class="fa fa-lock" data-toggle="tooltip" data-placement="top" title='{__("Shared with")} {__("Only Me")}'></i>
              {elseif $_post['privacy'] == "friends"}
                <i class="fa fa-users" data-toggle="tooltip" data-placement="top" title='{__("Shared with")} {__("Friends")}'></i>
              {elseif $_post['privacy'] == "public"}
                <i class="fa fa-globe" data-toggle="tooltip" data-placement="top" title='{__("Shared with")} {__("Public")}'></i>
              {elseif $_post['privacy'] == "custom"}
                <i class="fa fa-cog" data-toggle="tooltip" data-placement="top" title='{__("Shared with")} {__("Custom People")}'></i>
              {/if}
            {/if}
          {/if}
        </div>
        <!-- post time & location & privacy -->
      </div>
      <!-- post meta -->
    </div>
    <!-- post header -->

    <!-- post text -->
    {if $_post['post_type'] != "product" && $_post['post_type'] != "funding" && $_post['post_type'] != "offer" && $_post['post_type'] != "job"}
      {if !$_shared}
        {include file='__feeds_post.text.tpl'}
      {else}
        {if $_post['colored_pattern']}
          <div class="post-colored" {if $_post['colored_pattern']['type'] == "color"} style="background-image: linear-gradient(45deg, {$_post['colored_pattern']['background_color_1']}, {$_post['colored_pattern']['background_color_2']});" {else} style="background-image: url({$system['system_uploads']}/{$_post['colored_pattern']['background_image']})" {/if}>
            <div class="post-colored-text-wrapper js_scroller" data-slimScroll-height="240">
              <div class="post-text" dir="auto" style="color: {$_post['colored_pattern']['text_color']};">
                {$_post['text']}
              </div>
            </div>
          </div>
        {else}
          <div class="post-text js_readmore" dir="auto">{$_post['text']}</div>
        {/if}
        <div class="post-text-translation x-hidden" dir="auto"></div>
      {/if}
    {/if}
    <!-- post text -->

    {if !$_shared && $_post['post_type'] == "shared" && $_post['origin']}
      <div class="post-snippet {if in_array($_post['origin']['post_type'], ['product', 'funding', 'job', 'poll'])}pb15{/if}">
        {if $_snippet}
          <div class="post-snippet-toggle text-link js_show-attachments">{__("Show Attachments")}</div>
        {/if}
        <div {if $_snippet}class="x-hidden" {/if}>
          {include file='__feeds_post.body.tpl' _post=$_post['origin'] _shared=true}
        </div>
      </div>

    {elseif $_post['post_type'] == "link" && $_post['link']}
      <div class="mt10">
        <div class="post-media">
          {if $_post['link']['source_thumbnail']}
            <a class="post-media-image" href="{$_post['link']['source_url']}" target="_blank" rel="nofollow">
              <div class="image" style="background-image:url('{$_post['link']['source_thumbnail']}');"></div>
              <div class="source">{$_post['link']['source_host']|upper}</div>
            </a>
          {/if}
          <div class="post-media-meta">
            <a class="title mb5" href="{$_post['link']['source_url']}" target="_blank" rel="nofollow">{$_post['link']['source_title']}</a>
            <div class="text mb5">{$_post['link']['source_text']}</div>
          </div>
        </div>
      </div>

    {elseif $_post['post_type'] == "media" && $_post['media']}
      <div class="mt10">
        {if $_post['media']['source_type'] == "photo"}
          <div class="post-media">
            <div class="post-media-image">
              <div class="image" style="background-image:url('{$_post['media']['source_url']}');"></div>
            </div>
            <div class="post-media-meta">
              <div class="source"><a target="_blank" href="{$_post['media']['source_url']}">{$_post['media']['source_provider']}</a></div>
            </div>
          </div>
        {else}
          {if $_post['media']['source_provider'] == "YouTube"}
            {if $system['smart_yt_player']}
              {$_post['media']['vidoe_id'] = get_youtube_id($_post['media']['source_html'])}
              <div class="youtube-player js_youtube-player" data-id="{$_post['media']['vidoe_id']}">
                <img src="https://i.ytimg.com/vi/{$_post['media']['vidoe_id']}/hqdefault.jpg">
                <div class="play"></div>
              </div>
            {else}
              <div class="post-media">
                <div class="embed-responsive embed-responsive-16by9">
                  {html_entity_decode($_post['media']['source_html'], ENT_QUOTES)}
                </div>
              </div>
            {/if}

          {elseif $_post['media']['source_provider'] == "Vimeo" || $_post['media']['source_provider'] == "SoundCloud" || $_post['media']['source_provider'] == "Rumble.com" || $_post['media']['source_provider'] == "Banned.Video" || $_post['media']['source_provider'] == "brighteon"}
            <div class="post-media">
              <div class="embed-responsive embed-responsive-16by9">
                {html_entity_decode($_post['media']['source_html'], ENT_QUOTES)}
              </div>
            </div>
          {else}
            <div class="embed-ifram-wrapper">
              {html_entity_decode($_post['media']['source_html'], ENT_QUOTES)}
            </div>
          {/if}
        {/if}
      </div>

    {elseif $_post['post_type'] == "live" && $_post['live']}
      {if $system['save_live_enabled'] && $_post['live']['live_ended'] && $_post['live']['live_recorded']}
        <div class="overflow-hidden">
          <video class="js_videojs video-js vjs-fluid vjs-default-skin" id="video-{$_post['live']['live_id']}{if $pinned || $boosted}-{$_post['post_id']}{/if}" {if $_post['live']['video_thumbnail']}poster="{$system['system_uploads']}/{$_post['live']['video_thumbnail']}" {/if} controls preload="auto">
            <source src="{$system['system_agora_uploads']}/{$_post['live']['agora_file']}" type="application/x-mpegURL">
          </video>
        </div>
      {else}
        <div class="youtube-player with-live js_lightbox-live">
          <img src="{$system['system_uploads']}/{$_post['live']['video_thumbnail']}">
          <div class="play"></div>
        </div>
      {/if}

    {elseif $_post['post_type'] == "photos" || $_post['post_type'] == "album" || $_post['post_type'] == "profile_picture" || $_post['post_type'] == "profile_cover" || $_post['post_type'] == "page_picture" || $_post['post_type'] == "page_cover" || $_post['post_type'] == "group_picture" || $_post['post_type'] == "group_cover" || $_post['post_type'] == "event_cover" || ($_post['post_type'] == "product" && $_post['photos_num'] > 0)}
      <div class="mt10 clearfix">
        <div class="pg_wrapper">
          {if $_post['photos_num'] == 1}
            <div class="pg_1x {if $_post['photos'][0]['blur']}x-blured{/if}">
              <a href="{$system['system_url']}/photos/{$_post['photos'][0]['photo_id']}" class="js_lightbox" data-id="{$_post['photos'][0]['photo_id']}" data-image="{$system['system_uploads']}/{$_post['photos'][0]['source']}" data-context="{if $_post['post_type'] == 'product'}post{else}album{/if}">
                <img src="{$system['system_uploads']}/{$_post['photos'][0]['source']}">
              </a>
            </div>
          {elseif $_post['photos_num'] == 2}
            {foreach $_post['photos'] as $photo}
              <div class="pg_2x {if $photo['blur']}x-blured{/if}">
                <a href="{$system['system_url']}/photos/{$photo['photo_id']}" class="js_lightbox" data-id="{$photo['photo_id']}" data-image="{$system['system_uploads']}/{$photo['source']}" data-context="post" style="background-image:url('{$system['system_uploads']}/{$photo['source']}');"></a>
              </div>
            {/foreach}
          {elseif $_post['photos_num'] == 3}
            <div class="pg_3x">
              <div class="pg_2o3">
                <div class="pg_2o3_in {if $_post['photos'][0]['blur']}x-blured{/if}">
                  <a href="{$system['system_url']}/photos/{$_post['photos'][0]['photo_id']}" class="js_lightbox" data-id="{$_post['photos'][0]['photo_id']}" data-image="{$system['system_uploads']}/{$_post['photos'][0]['source']}" data-context="post" style="background-image:url('{$system['system_uploads']}/{$_post['photos'][0]['source']}');"></a>
                </div>
              </div>
              <div class="pg_1o3">
                <div class="pg_1o3_in {if $_post['photos'][1]['blur']}x-blured{/if}">
                  <a href="{$system['system_url']}/photos/{$_post['photos'][1]['photo_id']}" class="js_lightbox" data-id="{$_post['photos'][1]['photo_id']}" data-image="{$system['system_uploads']}/{$_post['photos'][1]['source']}" data-context="post" style="background-image:url('{$system['system_uploads']}/{$_post['photos'][1]['source']}');"></a>
                </div>
                <div class="pg_1o3_in {if $_post['photos'][2]['blur']}x-blured{/if}">
                  <a href="{$system['system_url']}/photos/{$_post['photos'][2]['photo_id']}" class="js_lightbox" data-id="{$_post['photos'][2]['photo_id']}" data-image="{$system['system_uploads']}/{$_post['photos'][2]['source']}" data-context="post" style="background-image:url('{$system['system_uploads']}/{$_post['photos'][2]['source']}');"></a>
                </div>
              </div>
            </div>
          {else}
            <div class="pg_4x">
              <div class="pg_2o3">
                <div class="pg_2o3_in {if $_post['photos'][0]['blur']}x-blured{/if}">
                  <a href="{$system['system_url']}/photos/{$_post['photos'][0]['photo_id']}" class="js_lightbox" data-id="{$_post['photos'][0]['photo_id']}" data-image="{$system['system_uploads']}/{$_post['photos'][0]['source']}" data-context="post" style="background-image:url('{$system['system_uploads']}/{$_post['photos'][0]['source']}');"></a>
                </div>
              </div>
              <div class="pg_1o3">
                <div class="pg_1o3_in {if $_post['photos'][1]['blur']}x-blured{/if}">
                  <a href="{$system['system_url']}/photos/{$_post['photos'][1]['photo_id']}" class="js_lightbox" data-id="{$_post['photos'][1]['photo_id']}" data-image="{$system['system_uploads']}/{$_post['photos'][1]['source']}" data-context="post" style="background-image:url('{$system['system_uploads']}/{$_post['photos'][1]['source']}');"></a>
                </div>
                <div class="pg_1o3_in {if $_post['photos'][2]['blur']}x-blured{/if}">
                  <a href="{$system['system_url']}/photos/{$_post['photos'][2]['photo_id']}" class="js_lightbox" data-id="{$_post['photos'][2]['photo_id']}" data-image="{$system['system_uploads']}/{$_post['photos'][2]['source']}" data-context="post" style="background-image:url('{$system['system_uploads']}/{$_post['photos'][2]['source']}');"></a>
                </div>
                <div class="pg_1o3_in {if $_post['photos'][3]['blur']}x-blured{/if}">
                  <a href="{$system['system_url']}/photos/{$_post['photos'][3]['photo_id']}" class="js_lightbox" data-id="{$_post['photos'][3]['photo_id']}" data-image="{$system['system_uploads']}/{$_post['photos'][3]['source']}" data-context="post" style="background-image:url('{$system['system_uploads']}/{$_post['photos'][3]['source']}');">
                    {if $_post['photos_num'] > 4}
                      <span class="more">+{$_post['photos_num']-4}</span>
                    {/if}
                  </a>
                </div>
              </div>
            </div>
          {/if}
        </div>
      </div>

    {elseif $_post['post_type'] == "map"}
      <div class="post-map">
        <img src="https://maps.googleapis.com/maps/api/staticmap?center={$_post['location']}&amp;zoom=20&amp;size=600x250&amp;maptype=roadmap&amp;markers=color:red%7C{$_post['location']}&amp;key={$system['geolocation_key']}" width="100%">
      </div>

    {elseif $_post['post_type'] == "article" && $_post['article']}
      <div class="mt10">
        <div class="post-media">
          {if $_post['article']['cover']}
            <a class="post-media-image" href="{$system['system_url']}/blogs/{$_post['post_id']}/{$_post['article']['title_url']}">
              <div style="padding-top: 50%; background-size: cover; background-image:url('{$system['system_uploads']}/{$_post['article']['cover']}');"></div>
            </a>
          {/if}
          <div class="post-media-meta">
            <a class="title mb5" href="{$system['system_url']}/blogs/{$_post['post_id']}/{$_post['article']['title_url']}">{$_post['article']['title']}</a>
            <div class="text mb5">{$_post['article']['text_snippet']|truncate:400}</div>
          </div>
        </div>
      </div>

    {elseif $_post['post_type'] == "funding" && $_post['funding']}
      <div class="mt10">
        <div class="post-media">
          <a class="post-media-image" href="{$system['system_url']}/posts/{$_post['post_id']}" target="_blank">
            <div class="image" style="background-image:url('{$system['system_uploads']}/{$_post['funding']['cover_image']}');"></div>
            <div class="icon">
              {include file='__svg_icons.tpl' icon="funding" width="32px" height="32px"}
            </div>
          </a>
        </div>
        <div class="post-funding-meta">
          <div class="funding-title mb10 mt20">
            <a href="{$system['system_url']}/posts/{$_post['post_id']}" target="_blank">{$_post['funding']['title']}</a>
          </div>
          <div class="funding-completion mb10 mt20">
            <span class="float-right">{$_post['funding']['funding_completion']}%</span>
            <strong>{print_money($_post['funding']['raised_amount'])} {__("Raised of")} {print_money($_post['funding']['amount'])}</strong>
            <div class="progress mt5">
              <div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar" aria-valuenow="{$_post['funding']['funding_completion']}" aria-valuemin="0" aria-valuemax="100" style="width: {$_post['funding']['funding_completion']}%"></div>
            </div>
          </div>
          <div class="funding-description">
            <!-- post text -->
            {if !$_shared}
              {include file='__feeds_post.text.tpl'}
            {else}
              <div class="post-text js_readmore text-muted" dir="auto">{$_post['text']}</div>
              <div class="post-text-translation x-hidden" dir="auto"></div>
            {/if}
            <!-- post text -->
          </div>
          {if $user->_logged_in && $_post['author_id'] != $user->_data['user_id'] }
            <div class="mt10 clearfix">
              <button type="button" class="btn btn-success btn-block js_funding-donate" data-toggle="modal" data-url="#funding-donate" data-options='{literal}{{/literal}"post_id": {$_post["post_id"]}{literal}}{/literal}'>
                <i class="fa fa-hand-holding-usd mr5"></i>{__("Donate")}
              </button>
            </div>
          {/if}
        </div>
      </div>

    {elseif $_post['post_type'] == "offer" && $_post['offer']}
      <div class="mt10">
        <div class="post-media">
          <a class="post-media-image" href="{$system['system_url']}/posts/{$_post['post_id']}" target="_blank">
            <div class="image" style="background-image:url('{$system['system_uploads']}/{$_post['offer']['thumbnail']}');"></div>
            <div class="source">
              <i class="far fa-calendar-alt mr5"></i>{__("Expires")}: <strong>{$_post['offer']['end_date']|date_format:"%d/%m/%Y"}</strong>
            </div>
            <div class="icon">
              {include file='__svg_icons.tpl' icon="offers" width="32px" height="32px"}
            </div>
          </a>
          <div class="post-media-meta">
            <a class="title mb5 mt20" href="{$system['system_url']}/posts/{$_post['post_id']}" target="_blank">{$_post['offer']['meta_title']}</a>
            <!-- post text -->
            {if !$_shared}
              {include file='__feeds_post.text.tpl'}
            {else}
              <div class="post-text js_readmore text-muted" dir="auto">{$_post['text']}</div>
              <div class="post-text-translation x-hidden" dir="auto"></div>
            {/if}
            <!-- post text -->
            <!-- custom fileds -->
            {if $_post['custom_fields']['basic']}
              <div class="post-custom-fileds-wrapper mt10">
                {foreach $_post['custom_fields']['basic'] as $custom_field}
                  {if $custom_field['value']}
                    <div>
                      <strong>{__($custom_field['label'])}</strong><br>
                      {if $custom_field['type'] == "textbox" && $custom_field['is_link']}
                        <a href="{$custom_field['value']}">{$custom_field['value']}</a>
                      {elseif $custom_field['type'] == "multipleselectbox"}
                        {$custom_field['value_string']}
                      {else}
                        {$custom_field['value']}
                      {/if}
                    </div>
                  {/if}
                {/foreach}
              </div>
            {/if}
            <!-- custom fileds -->
          </div>
        </div>
      </div>

    {elseif $_post['post_type'] == "job" && $_post['job']}
      <div class="mt10">
        <div class="post-media">
          <a class="post-media-image" href="{$system['system_url']}/posts/{$_post['post_id']}" target="_blank">
            <div class="image" style="background-image:url('{$system['system_uploads']}/{$_post['job']['cover_image']}');"></div>
            <div class="source">
              <strong>{print_money($_post['job']['salary_minimum'])} - {print_money($_post['job']['salary_maximum'])} / {$_post['job']['pay_salary_per_meta']}</strong>
            </div>
            <div class="icon">
              {include file='__svg_icons.tpl' icon="jobs" width="32px" height="32px"}
            </div>
          </a>
        </div>
        <div class="post-job-meta">
          <div class="job-title mb10 mt20">
            <a href="{$system['system_url']}/posts/{$_post['post_id']}" target="_blank">{$_post['job']['title']}</a>
          </div>
          <div class="post-product-wrapper">
            <div class="post-product-details">
              <div class="title">
                <i class="fa fa-map-marker fa-fw mr5" style="color: #1f9cff;"></i>{__("Location")}
              </div>
              <div class="description">
                {$_post['job']['location']}
              </div>
            </div>
            <div class="post-product-details">
              <div class="title">
                <i class="fa fa-briefcase fa-fw mr5" style="color: #2bb431;"></i>{__("Type")}
              </div>
              <div class="description">
                {$_post['job']['type_meta']}
              </div>
            </div>
            <div class="post-product-details">
              <div class="title">
                <i class="fa fa-clock fa-fw mr5" style="color: #a038b2;"></i>{__("Status")}
              </div>
              <div class="description">
                {if $_post['job']['available']}
                  <span class="badge badge-success">{__("Open")}</span>
                {else}
                  <span class="badge badge-danger">{__("Closed")}</span>
                {/if}
              </div>
            </div>
          </div>
          <div class="job-description">
            <!-- post text -->
            {if !$_shared}
              {include file='__feeds_post.text.tpl'}
            {else}
              <div class="post-text js_readmore text-muted" dir="auto">{$_post['text']}</div>
              <div class="post-text-translation x-hidden" dir="auto"></div>
            {/if}
            <!-- post text -->
          </div>
          <!-- custom fileds -->
          {if $_post['custom_fields']['basic']}
            <div class="post-custom-fileds-wrapper mt10">
              {foreach $_post['custom_fields']['basic'] as $custom_field}
                {if $custom_field['value']}
                  <div>
                    <strong>{__($custom_field['label'])}</strong><br>
                    {if $custom_field['type'] == "textbox" && $custom_field['is_link']}
                      <a href="{$custom_field['value']}">{$custom_field['value']}</a>
                    {elseif $custom_field['type'] == "multipleselectbox"}
                      {$custom_field['value_string']}
                    {else}
                      {$custom_field['value']}
                    {/if}
                  </div>
                {/if}
              {/foreach}
            </div>
          {/if}
          <!-- custom fileds -->
          {if $_post['author_id'] == $user->_data['user_id']}
            <div class="mt10 clearfix">
              <button type="button" class="btn btn-primary btn-block js_job-apply" data-toggle="modal" data-url="posts/job.php?do=candidates&post_id={$_post['post_id']}" {if $_post['job']['candidates_count'] == 0}disabled{/if}>
                <i class="fa fa-users mr5"></i>{__("View Candidates")} ({$_post['job']['candidates_count']})
              </button>
            </div>
          {/if}
          {if $user->_logged_in && $_post['job']['available'] &&  $_post['author_id'] != $user->_data['user_id'] }
            <div class="mt10 clearfix">
              <button type="button" class="btn btn-success btn-block js_job-apply" data-toggle="modal" data-url="posts/job.php?do=application&post_id={$_post['post_id']}">
                <i class="fa fa-user-tie mr5"></i>{__("Apply Now")}
              </button>
            </div>
          {/if}
        </div>
      </div>

    {elseif $_post['post_type'] == "poll" && $_post['poll']}
      <div class="poll-options mt10" data-poll-votes="{$_post['poll']['votes']}">
        {foreach $_post['poll']['options'] as $option}
          <div class="mb5">
            <div class="poll-option js_poll-vote" data-id="{$option['option_id']}" data-option-votes="{$option['votes']}">
              <div class="percentage-bg" {if $_post['poll']['votes'] > 0} style="width: {($option['votes']/$_post['poll']['votes'])*100}%" {/if}></div>
              <div class="custom-control custom-radio custom-control-inline">
                <input type="radio" name="poll_{$_post['poll']['poll_id']}" id="option_{$option['option_id']}" class="custom-control-input" {if $option['checked']}checked{/if}>
                <label class="custom-control-label" for="option_{$option['option_id']}">{$option['text']}</label>
              </div>
            </div>
            <div class="poll-voters">
              <div class="more" data-toggle="modal" data-url="posts/who_votes.php?option_id={$option['option_id']}">
                {$option['votes']}
              </div>
            </div>
          </div>
        {/foreach}
      </div>

    {elseif $_post['post_type'] == "video" && $_post['video']}
      <div class="overflow-hidden">
        <video class="js_videojs video-js vjs-16-9 vjs-default-skin" id="video-{$_post['video']['video_id']}{if $pinned || $boosted}-{$_post['post_id']}{/if}" {if $user->_logged_in}onplay="update_media_views('video', {$_post['video']['video_id']})" {/if} {if $_post['video']['thumbnail']}poster="{$system['system_uploads']}/{$_post['video']['thumbnail']}" {/if} controls preload="auto" muted="muted" style="width:100%;height:100%;" width="100%" height="100%">
          <source src="{$system['system_uploads']}/{$_post['video']['source']}" type="video/mp4">
          <source src="{$system['system_uploads']}/{$_post['video']['source']}" type="video/webm">
        </video>
      </div>

    {elseif $_post['post_type'] == "audio" && $_post['audio']}
      <div class="plr10">
        <audio class="js_audio" id="audio-{$_post['audio']['audio_id']}" {if $user->_logged_in}onplay="update_media_views('audio', {$_post['audio']['audio_id']})" {/if} controls preload="auto" style="width: 100%;">
          <source src="{$system['system_uploads']}/{$_post['audio']['source']}" type="audio/mpeg">
          <source src="{$system['system_uploads']}/{$_post['audio']['source']}" type="audio/mp3">
          {__("Your browser does not support HTML5 audio")}
        </audio>
      </div>

    {elseif $_post['post_type'] == "file" && $_post['file']}
      <div class="post-downloader">
        <div class="icon">
          <i class="fa fa-file-alt fa-2x"></i>
        </div>
        <div class="info">
          <strong>{__("File Type")}</strong>: {get_extension({$_post['file']['source']})}
          <div class="mt10">
            <a class="btn btn-primary btn-sm" href="{$system['system_uploads']}/{$_post['file']['source']}">{__("Download")}</a>
          </div>
        </div>
      </div>

    {/if}

    <!-- product -->
    {if $_post['post_type'] == "product" && $_post['product']}
      <div class="post-product-container">
        <div class="mtb10 text-xlg">
          <strong>{$_post['product']['name']}</strong>
        </div>
        {if $_post['product']['location']}
          <div class="mb10 text-muted">
            <i class="fa fa-map-marker fa-fw mr5"></i>{$_post['product']['location']}
          </div>
        {/if}
        <div class="mb10 text-muted">
          <i class="fa fa-cube fa-fw mr5"></i>{__($_post['product']['category_name'])}
        </div>
        <!-- post text -->
        {if !$_shared}
          {include file='__feeds_post.text.tpl'}
        {else}
          <div class="post-text js_readmore text-muted" dir="auto">{$_post['text']}</div>
          <div class="post-text-translation x-hidden" dir="auto"></div>
        {/if}
        <!-- post text -->
        <div class="post-product-wrapper mt10">
          <div class="post-product-details">
            <div class="title">
              <i class="fa fa-tag fa-fw mr5" style="color: #1f9cff;"></i>{__("Type")}
            </div>
            <div class="description">
              {if $_post['product']['status'] == "new"}
                {__("New")}
              {else}
                {__("Used")}
              {/if}
            </div>
          </div>
          <div class="post-product-details">
            <div class="title">
              <i class="fa fa-money-bill-alt fa-fw mr5" style="color: #2bb431;"></i>{__("Price")}
            </div>
            <div class="description">
              {if $_post['product']['price'] > 0}
                {print_money($_post['product']['price'], $_post['product']['symbol'], $_post['product']['dir'])} ({$_post['product']['code']})
              {else}
                {__("Free")}
              {/if}
            </div>
          </div>
          <div class="post-product-details">
            <div class="title">
              <i class="fa fa-box fa-fw mr5" style="color: #a038b2;"></i>{__("Status")}
            </div>
            <div class="description">
              {if $_post['product']['available']}
                <span class="badge badge-success">{__("In stock")}</span>
              {else}
                <span class="badge badge-danger">{__("SOLD")}</span>
              {/if}
            </div>
          </div>
        </div>
        <!-- custom fileds -->
        {if $_post['custom_fields']['basic']}
          <div class="post-custom-fileds-wrapper mt10">
            {foreach $_post['custom_fields']['basic'] as $custom_field}
              {if $custom_field['value']}
                <div>
                  <strong>{__($custom_field['label'])}</strong><br>
                  {if $custom_field['type'] == "textbox" && $custom_field['is_link']}
                    <a href="{$custom_field['value']}">{$custom_field['value']}</a>
                  {elseif $custom_field['type'] == "multipleselectbox"}
                    {$custom_field['value_string']}
                  {else}
                    {$custom_field['value']}
                  {/if}
                </div>
              {/if}
            {/foreach}
          </div>
        {/if}
        <!-- custom fileds -->
        {if $_post['product']['available'] && $_post['author_id'] != $user->_data['user_id'] }
          <div class="mt10 clearfix">
            <button type="button" class="btn btn-info btn-block js_chat-start" data-uid="{$_post['author_id']}" data-name="{$_post['post_author_name']}">
              <i class="fa fa-comments mr5"></i>{__("Contact Seller")}
            </button>
          </div>
        {/if}
      </div>
    {/if}
<!-- product -->