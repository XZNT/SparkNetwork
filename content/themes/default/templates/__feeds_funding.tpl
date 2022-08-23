<div class="{if $_iteration == 1}col-sm-12 col-md-8 col-lg-6{else}col-sm-6 col-md-4 col-lg-3{/if}">
  <a href="{$system['system_url']}/posts/{$funding['post_id']}" class="blog-container {if $_iteration == 1}primary{/if}">
    <div class="blog-image">
      <img src="{$system['system_uploads']}/{$funding['funding']['cover_image']}">
    </div>
    <div class="blog-source">
      <strong>{print_money($funding['funding']['raised_amount'])} {__("Raised of")} {print_money($funding['funding']['amount'])}</strong>
    </div>
    <div class="blog-content">
      <h3>{$funding['funding']['title']}</h3>
      <div class="text">{$funding['text']|truncate:400}</div>
      <div>
        <div class="post-avatar">
          <div class="post-avatar-picture small" style="background-image:url('{$funding['post_author_picture']}');">
          </div>
        </div>
        <div class="post-meta">
          <span class="text-link">
            {$funding['post_author_name']}
          </span>
          <div class="post-time">
            <span class="js_moment" data-time="{$funding['time']}">{$funding['time']}</span>
          </div>
        </div>
      </div>
    </div>
    <div class="blog-more">
      <span>{__("More")}</span>
    </div>
  </a>
</div>