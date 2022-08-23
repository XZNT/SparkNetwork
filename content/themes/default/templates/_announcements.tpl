{foreach $announcements as $announcement}
  <div class="alert alert-{$announcement['type']} text-with-list" data-id="{$announcement['announcement_id']}">
    {if $user->_logged_in}
      <button type="button" class="close float-right js_announcment-remover"><span>&times;</span></button>
    {/if}
    {if $announcement['title']}<div class="title">{$announcement['title']}</div>{/if}
    {$announcement['code']}
  </div>
{/foreach}