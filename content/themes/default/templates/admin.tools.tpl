<div class="card">

  {if $sub_view == "faker"}

    <!-- card-header -->
    <div class="card-header with-icon with-nav">
      <!-- panel title -->
      <div class="mb20">
        <i class="fa fa-toolbox mr10"></i>{__("Tools")} &rsaquo; {__("Fake Generator")}
      </div>
      <!-- panel title -->

      <!-- panel nav -->
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link active" href="#Users" data-toggle="tab">
            <i class="fa fa-user fa-fw mr5"></i><strong>{__("Users")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Pages" data-toggle="tab">
            <i class="fa fa-flag fa-fw mr5"></i><strong>{__("Pages")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Groups" data-toggle="tab">
            <i class="fa fa-users fa-fw mr5"></i><strong>{__("Groups")}</strong>
          </a>
        </li>
      </ul>
      <!-- panel nav -->
    </div>
    <!-- card-header -->

    <!-- tab-content -->
    <div class="tab-content">
      <!-- Users -->
      <div class="tab-pane active" id="Users">
        <form class="js_ajax-forms" data-url="admin/tools.php?do=faker&handle=users">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="profile" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Random Pictures")}</div>
                <div class="form-text d-none d-sm-block">{__("Profile pictures will be generated randomly and may be dublicated")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="users_random_Avatar">
                  <input type="checkbox" name="random_Avatar" id="users_random_Avatar">
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Number of Users")}
              </label>
              <div class="col-md-9">
                <input type="number" class="form-control" name="users_num" value="10">
                <span class="form-text">
                  {__("How many users you want to generate (Maximum is 1000 per request)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Password")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="default_password">
                <span class="form-text">
                  {__("This password will be used for all generated accounts (Default is 123456789)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Names Language")}
              </label>
              <div class="col-md-9">
                <select class="form-control" name="language">
                  {foreach $system['languages'] as $language}
                    {$parts = explode('_', $language['code'])}
                    <option {if $system['default_language']['language_id'] == $language['language_id']}selected{/if} value="{$parts[0]}_{strtoupper($parts[1])}">{$language['title']}</option>
                  {/foreach}
                </select>
                <span class="form-text">
                  {__("Select the language of generated names")}
                </span>
              </div>
            </div>

            <!-- success -->
            <div class="alert alert-success mb0 x-hidden"></div>
            <!-- success -->

            <!-- error -->
            <div class="alert alert-danger mb0 x-hidden"></div>
            <!-- error -->
          </div>
          <div class="card-footer text-right">
            <button type="submit" class="btn btn-danger"><i class="fa fa-bolt mr10"></i>{__("Generate")}</button>
          </div>
        </form>
      </div>
      <!-- Users -->

      <!-- Pages -->
      <div class="tab-pane" id="Pages">
        <form class="js_ajax-forms" data-url="admin/tools.php?do=faker&handle=pages">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="profile" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Random Pictures")}</div>
                <div class="form-text d-none d-sm-block">{__("Profile pictures will be generated randomly and may be dublicated")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="pages_random_Avatar">
                  <input type="checkbox" name="random_Avatar" id="pages_random_Avatar">
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Number of Pages")}
              </label>
              <div class="col-md-9">
                <input type="number" class="form-control" name="pages_num" value="10">
                <span class="form-text">
                  {__("How many pages you want to generate (Maximum is 1000 per request)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Names Language")}
              </label>
              <div class="col-md-9">
                <select class="form-control" name="language">
                  {foreach $system['languages'] as $language}
                    {$parts = explode('_', $language['code'])}
                    <option {if $system['default_language']['language_id'] == $language['language_id']}selected{/if} value="{$parts[0]}_{strtoupper($parts[1])}">{$language['title']}</option>
                  {/foreach}
                </select>
                <span class="form-text">
                  {__("Select the language of generated names")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Page Category")}
              </label>
              <div class="col-md-9">
                <select class="form-control" name="category" id="category">
                  <option>{__("Select Category")}</option>
                  {foreach $pages_categories as $category}
                    {include file='__categories.recursive_options.tpl'}
                  {/foreach}
                </select>
              </div>
            </div>

            <!-- success -->
            <div class="alert alert-success mb0 x-hidden"></div>
            <!-- success -->

            <!-- error -->
            <div class="alert alert-danger mb0 x-hidden"></div>
            <!-- error -->
          </div>
          <div class="card-footer text-right">
            <button type="submit" class="btn btn-danger"><i class="fa fa-bolt mr10"></i>{__("Generate")}</button>
          </div>
        </form>
      </div>
      <!-- Pages -->

      <!-- Groups -->
      <div class="tab-pane" id="Groups">
        <form class="js_ajax-forms" data-url="admin/tools.php?do=faker&handle=groups">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="profile" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Random Pictures")}</div>
                <div class="form-text d-none d-sm-block">{__("Profile pictures will be generated randomly and may be dublicated")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="groups_random_Avatar">
                  <input type="checkbox" name="random_Avatar" id="groups_random_Avatar">
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Number of Groups")}
              </label>
              <div class="col-md-9">
                <input type="number" class="form-control" name="groups_num" value="10">
                <span class="form-text">
                  {__("How many groups you want to generate (Maximum is 1000 per request)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Names Language")}
              </label>
              <div class="col-md-9">
                <select class="form-control" name="language">
                  {foreach $system['languages'] as $language}
                    {$parts = explode('_', $language['code'])}
                    <option {if $system['default_language']['language_id'] == $language['language_id']}selected{/if} value="{$parts[0]}_{strtoupper($parts[1])}">{$language['title']}</option>
                  {/foreach}
                </select>
                <span class="form-text">
                  {__("Select the language of generated names")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Group Category")}
              </label>
              <div class="col-md-9">
                <select class="form-control" name="category" id="category">
                  <option>{__("Select Category")}</option>
                  {foreach $groups_categories as $category}
                    {include file='__categories.recursive_options.tpl'}
                  {/foreach}
                </select>
              </div>
            </div>

            <!-- success -->
            <div class="alert alert-success mb0 x-hidden"></div>
            <!-- success -->

            <!-- error -->
            <div class="alert alert-danger mb0 x-hidden"></div>
            <!-- error -->
          </div>
          <div class="card-footer text-right">
            <button type="submit" class="btn btn-danger"><i class="fa fa-bolt mr10"></i>{__("Generate")}</button>
          </div>
        </form>
      </div>
      <!-- Groups -->
    </div>
    <!-- tab-content -->

  {elseif $sub_view == "auto-connect"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-toolbox mr10"></i>{__("Tools")} &rsaquo; {__("Auto Connect")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Auto Connect -->
    <form class="js_ajax-forms" data-url="admin/tools.php?do=auto-connect">
      <div class="card-body">
        <div class="heading-small mb20">
          {__("Auto Friend")}
        </div>
        <div class="pl-md-4">
          <div class="form-table-row">
            <div class="avatar">
              {include file='__svg_icons.tpl' icon="friends" width="40px" height="40px"}
            </div>
            <div>
              <div class="form-control-label h6">{__("Auto Friend")}</div>
              <div class="form-text d-none d-sm-block">{__("When a user creates a new account, select which users you want to auto friend (following included)")}</div>
            </div>
            <div class="text-right">
              <label class="switch" for="auto_friend">
                <input type="checkbox" name="auto_friend" id="auto_friend" {if $system['auto_friend']}checked{/if}>
                <span class="slider round"></span>
              </label>
            </div>
          </div>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Select Users")}
            </label>
            <div class="col-md-9">
              <input type="text" class="js_tagify x-hidden" data-handle="users" name="auto_friend_users" value='{$system['auto_friend_users']}'>
              <span class="form-text">
                {__("Search for users you want new accounts to auto friend")}
              </span>
            </div>
          </div>
        </div>

        <div class="divider"></div>

        <div class="heading-small mb20">
          {__("Auto Follow")}
        </div>
        <div class="pl-md-4">
          <div class="form-table-row">
            <div class="avatar">
              {include file='__svg_icons.tpl' icon="followers" width="40px" height="40px"}
            </div>
            <div>
              <div class="form-control-label h6">{__("Auto Follow")}</div>
              <div class="form-text d-none d-sm-block">{__("When a user creates a new account, select which users you want to auto follow")}</div>
            </div>
            <div class="text-right">
              <label class="switch" for="auto_follow">
                <input type="checkbox" name="auto_follow" id="auto_follow" {if $system['auto_follow']}checked{/if}>
                <span class="slider round"></span>
              </label>
            </div>
          </div>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Select Users")}
            </label>
            <div class="col-md-9">
              <input type="text" class="js_tagify x-hidden" data-handle="users" name="auto_follow_users" value='{$system['auto_follow_users']}'>
              <span class="form-text">
                {__("Search for users you want new accounts to auto follow")}
              </span>
            </div>
          </div>
        </div>

        <div class="divider"></div>

        <div class="heading-small mb20">
          {__("Auto Like")}
        </div>
        <div class="pl-md-4">
          <div class="form-table-row">
            <div class="avatar">
              {include file='__svg_icons.tpl' icon="pages" width="40px" height="40px"}
            </div>
            <div>
              <div class="form-control-label h6">{__("Auto Like")}</div>
              <div class="form-text d-none d-sm-block">{__("When a user creates a new account, select which pages you want to auto like")}</div>
            </div>
            <div class="text-right">
              <label class="switch" for="auto_like">
                <input type="checkbox" name="auto_like" id="auto_like" {if $system['auto_like']}checked{/if}>
                <span class="slider round"></span>
              </label>
            </div>
          </div>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Select Pages")}
            </label>
            <div class="col-md-9">
              <input type="text" class="js_tagify x-hidden" data-handle="pages" name="auto_like_pages" value='{$system['auto_like_pages']}'>
              <span class="form-text">
                {__("Search for pages you want new accounts to auto like")}
              </span>
            </div>
          </div>
        </div>

        <div class="divider"></div>

        <div class="heading-small mb20">
          {__("Auto Join")}
        </div>
        <div class="pl-md-4">
          <div class="form-table-row">
            <div class="avatar">
              {include file='__svg_icons.tpl' icon="groups" width="40px" height="40px"}
            </div>
            <div>
              <div class="form-control-label h6">{__("Auto Join")}</div>
              <div class="form-text d-none d-sm-block">{__("When a user creates a new account, select which groups you want to auto join")}</div>
            </div>
            <div class="text-right">
              <label class="switch" for="auto_join">
                <input type="checkbox" name="auto_join" id="auto_join" {if $system['auto_join']}checked{/if}>
                <span class="slider round"></span>
              </label>
            </div>
          </div>
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Select Groups")}
            </label>
            <div class="col-md-9">
              <input type="text" class="js_tagify x-hidden" data-handle="groups" name="auto_join_groups" value='{$system['auto_join_groups']}'>
              <span class="form-text">
                {__("Search for groups you want new accounts to auto join")}
              </span>
            </div>
          </div>
        </div>

        <!-- success -->
        <div class="alert alert-success mb0 x-hidden"></div>
        <!-- success -->

        <!-- error -->
        <div class="alert alert-danger mb0 x-hidden"></div>
        <!-- error -->
      </div>
      <div class="card-footer text-right">
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>
    <!-- Auto Connect -->

  {elseif $sub_view == "garbage-collector"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-toolbox mr10"></i>{__("Tools")} &rsaquo; {__("Garbage Collector")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Garbage Collector -->
    <form class="js_ajax-forms" data-url="admin/tools.php?do=garbage-collector">
      <div class="card-body">

        <div class="alert alert-info">
          <div class="icon">
            <i class="fa fa-info-circle fa-2x"></i>
          </div>
          <div class="text pt5">
            {__("Garbage collector will perform the selected action and might take some time")}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("What you want to do")}
          </label>
          <div class="col-md-9">
            <select class="form-control" name="delete">
              <option value="users_not_activated">{__("Delete all not activated accounts")} ({$insights['users_not_activated']} {__("user")})</option>
              <option value="users_not_logged_week">{__("Delete users who did not login from 1 week")} ({$insights['users_not_logged_week']} {__("user")})</option>
              <option value="users_not_logged_month">{__("Delete users who did not login from 1 month")} ({$insights['users_not_logged_month']} {__("user")})</option>
              <option value="users_not_logged_3_months">{__("Delete users who did not login from 3 months")} ({$insights['users_not_logged_3_months']} {__("user")})</option>
              <option value="users_not_logged_6_months">{__("Delete users who did not login from 6 months")} ({$insights['users_not_logged_6_months']} {__("user")})</option>
              <option value="users_not_logged_9_months">{__("Delete users who did not login from 9 months")} ({$insights['users_not_logged_9_months']} {__("user")})</option>
              <option value="users_not_logged_year">{__("Delete users who did not login from 1 year")} ({$insights['users_not_logged_year']} {__("user")})</option>
              <option value="posts_longer_week">{__("Delete posts that are longer than 1 week")} ({$insights['posts_longer_week']} {__("post")})</option>
              <option value="posts_longer_month">{__("Delete posts that are longer than 1 month")} ({$insights['posts_longer_month']} {__("post")})</option>
              <option value="posts_longer_year">{__("Delete posts that are longer than 1 year")} ({$insights['posts_longer_year']} {__("post")})</option>
              <option value="packages">{__("Reset all expired subscribers and their boosted posts and pages")}</option>
              <option value="user_points">{__("Reset all users points")}</option>
            </select>
          </div>
        </div>

        <!-- success -->
        <div class="alert alert-success mb0 x-hidden"></div>
        <!-- success -->

        <!-- error -->
        <div class="alert alert-danger mb0 x-hidden"></div>
        <!-- error -->
      </div>
      <div class="card-footer text-right">
        <button type="submit" class="btn btn-danger"><i class="fa fa-bolt mr10"></i>{__("Run")}</button>
      </div>
    </form>
    <!-- Garbage Collector -->

  {elseif $sub_view == "backups"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-toolbox mr10"></i>{__("Tools")} &rsaquo; {__("Backup Database & Files")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Backup Database & Files -->
    <form class="js_ajax-forms" data-url="admin/tools.php?do=backups">
      <div class="card-body">

        <div class="alert alert-primary">
          <div class="icon">
            <i class="fa fa-server fa-2x"></i>
          </div>
          <div class="text">
            {__("You last backup")} <span class="badge badge-pill badge-lg badge-warning">{if $system['last_backup_time']}{$system['last_backup_time']}{else}{__("N/A")}{/if}</span><br>
            {__("You can find backups in")} <strong>content/backups</strong><br>
            {__("Taking backup might take some time and you can download backups via FTP")}
          </div>
        </div>

        <div class="h5 mb20 text-center">
          {__("Select which backup you would like to generate")}
        </div>
        <!-- backup options -->
        <div class="text-center">
          <!-- Database -->
          <input class="x-hidden input-label" type="radio" name="backup_option" value="datebase_backup" id="datebase_backup" />
          <label class="button-label" for="datebase_backup">
            <div class="icon">
              {include file='__svg_icons.tpl' icon="database" width="32px" height="32px"}
            </div>
            <div class="title">{__("Database")}</div>
          </label>
          <!-- Database -->
          <!-- Files -->
          <input class="x-hidden input-label" type="radio" name="backup_option" value="files_backup" id="files_backup" />
          <label class="button-label" for="files_backup">
            <div class="icon">
              {include file='__svg_icons.tpl' icon="folder" width="32px" height="32px"}
            </div>
            <div class="title">{__("Files")}</div>
          </label>
          <!-- Files -->
          <!-- Full -->
          <input class="x-hidden input-label" type="radio" name="backup_option" value="full_backup" id="full_backup" />
          <label class="button-label" for="full_backup">
            <div class="icon">
              {include file='__svg_icons.tpl' icon="full_backup" width="32px" height="32px"}
            </div>
            <div class="title">{__("Full Backup")}</div>
          </label>
          <!-- Full -->
        </div>
        <!-- backup options -->

        <!-- success -->
        <div class="alert alert-success mt10 mb0 x-hidden"></div>
        <!-- success -->

        <!-- error -->
        <div class="alert alert-danger mt10 mb0 x-hidden"></div>
        <!-- error -->
      </div>
      <div class="card-footer text-right">
        <button type="submit" class="btn btn-danger"><i class="fa fa-bolt mr10"></i>{__("Run")}</button>
      </div>
    </form>
    <!-- Backup Database & Files -->

  {elseif $sub_view == "reset"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-toolbox mr10"></i>{__("Tools")} &rsaquo; {__("Factory Reset")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Factory Reset -->
    <div class="card-body">
      <div class="alert alert-warning">
        <div class="icon">
          <i class="fa fa-exclamation-triangle fa-2x"></i>
        </div>
        <div class="text pt5">
          {__("Once you reset your website all data will be deleted and it will be like having a fresh installation")}<br>
          {__("(Note: All system settings will be saved)")}
        </div>
      </div>

      <div class="text-center">
        <button class="btn btn-md btn-danger js_admin-reset">
          <i class="fa fa-trash fa-lg mr10"></i>{__("Reset Everything")}
        </button>
      </div>
    </div>
    <!-- Factory Reset -->

  {/if}

</div>