<div class="card">

  {if $sub_view == ""}

    <!-- card-header -->
    <div class="card-header with-icon with-nav">
      <!-- panel title -->
      <div class="mb20">
        <i class="fa fa-cog mr10"></i>{__("Settings")}
      </div>
      <!-- panel title -->

      <!-- panel nav -->
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link active" href="#General" data-toggle="tab">
            <i class="fa fa-server fa-fw mr5"></i><strong>{__("General")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#SEO" data-toggle="tab">
            <i class="fa fa-sitemap fa-fw mr5"></i><strong>{__("SEO")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Modules" data-toggle="tab">
            <i class="fa fa-dice-d6 fa-fw mr5"></i><strong>{__("Modules")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Features" data-toggle="tab">
            <i class="fa fa-microchip fa-fw mr5"></i><strong>{__("Features")}</strong>
          </a>
        </li>
      </ul>
      <!-- panel nav -->
    </div>
    <!-- card-header -->

    <!-- tab-content -->
    <div class="tab-content">
      <!-- General -->
      <div class="tab-pane active" id="General">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=general">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="website_live" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Website Live")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the entire website On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="system_live">
                  <input type="checkbox" name="system_live" id="system_live" {if $system['system_live']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Shutdown Message")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_message" rows="3">{$system['system_message']}</textarea>
                <span class="form-text">
                  {__("The text that is presented when the site is closed")}
                </span>
              </div>
            </div>

            <div class="divider dashed"></div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("System Email")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="system_email" value="{$system['system_email']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("The contact email that all messages send to")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("System Datetime Format")}
              </label>
              <div class="col-md-9">
                <select class="form-control" name="system_datetime_format">
                  <option {if $system['system_datetime_format'] == "d/m/Y H:i"}selected{/if} value="d/m/Y H:i">d/m/Y H:i ({__("Example")}: 30/05/2019 17:30)</option>
                  <option {if $system['system_datetime_format'] == "m/d/Y H:i"}selected{/if} value="m/d/Y H:i">m/d/Y H:i ({__("Example")}: 05/30/2019 17:30)</option>
                </select>
                <span class="form-text">
                  {__("Select the datetime format of the datetime picker")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("System Distance Unit")}
              </label>
              <div class="col-md-9">
                <select class="form-control" name="system_distance">
                  <option {if $system['system_distance'] == "mile"}selected{/if} value="mile">{__("Mile")}</option>
                  <option {if $system['system_distance'] == "kilometer"}selected{/if} value="kilometer">{__("Kilometer")}</option>
                </select>
                <span class="form-text">
                  {__("Select the distance measure unit of your website")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("System Currency")}
              </label>
              <div class="col-md-9">
                <select class="form-control" name="system_currency">
                  {foreach $system_currencies as $currency}
                    <option {if $currency['default']}selected{/if} value="{$currency['currency_id']}">
                      {$currency['name']} ({$currency['code']})
                    </option>
                  {/foreach}
                </select>
                <div class="form-text">
                  {__("You can add, edit or delete currencies from")} <a href="{$system['system_url']}/{$control_panel['url']}/currencies">{__("Currencies")}</a>
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
      </div>
      <!-- General -->

      <!-- SEO -->
      <div class="tab-pane" id="SEO">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=seo">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="website_public" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Website Public")}</div>
                <div class="form-text d-none d-sm-block">{__("Make the website public to allow non logged users to view website content")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="system_public">
                  <input type="checkbox" name="system_public" id="system_public" {if $system['system_public']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="newsfeed" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Newsfeed Public")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Make the newsfeed available for visitors in landing page")}<br>
                  {__("Enable this will make your website public and list only public posts")}
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="newsfeed_public">
                  <input type="checkbox" name="newsfeed_public" id="newsfeed_public" {if $system['newsfeed_public']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="directory" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6"> {__("Directory")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Enable the directory for better SEO results")}<br>
                  {__("Make the website public to allow non logged users to view website content")}
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="directory_enabled">
                  <input type="checkbox" name="directory_enabled" id="directory_enabled" {if $system['directory_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Website Title")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="system_title" value="{__($system['system_title'])}">
                <span class="form-text">
                  {__("Title of your website")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Website Description")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_description" rows="3">{$system['system_description']}</textarea>
                <span class="form-text">
                  {__("Description of your website")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Website Keywords")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_keywords" rows="3">{$system['system_keywords']}</textarea>
                <span class="form-text">
                  {__("Example: social, sngine, social site")}
                </span>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Directory Description")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_description_directory" rows="3">{$system['system_description_directory']}</textarea>
                <span class="form-text">
                  {__("Description of your Directory")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Blogs Description")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_description_blogs" rows="3">{$system['system_description_blogs']}</textarea>
                <span class="form-text">
                  {__("Description of your blogs module")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Marketplace Description")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_description_marketplace" rows="3">{$system['system_description_marketplace']}</textarea>
                <span class="form-text">
                  {__("Description of your marketplace module")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Funding Description")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_description_funding" rows="3">{$system['system_description_funding']}</textarea>
                <span class="form-text">
                  {__("Description of your funding module")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Offers Description")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_description_offers" rows="3">{$system['system_description_offers']}</textarea>
                <span class="form-text">
                  {__("Description of your offer module")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Jobs Description")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_description_jobs" rows="3">{$system['system_description_jobs']}</textarea>
                <span class="form-text">
                  {__("Description of your jobs module")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Forums Description")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_description_forums" rows="3">{$system['system_description_forums']}</textarea>
                <span class="form-text">
                  {__("Description of your forums module")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Movies Description")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="system_description_movies" rows="3">{$system['system_description_movies']}</textarea>
                <span class="form-text">
                  {__("Description of your movies module")}
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
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- SEO -->

      <!-- Modules -->
      <div class="tab-pane" id="Modules">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=modules">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="pages" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Pages")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the pages On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="pages_enabled">
                  <input type="checkbox" name="pages_enabled" id="pages_enabled" {if $system['pages_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Who Can Create Pages")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="pages_permission">
                  <option value="admins" {if $system['pages_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
                  <option value="pro" {if $system['pages_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
                  <option value="verified" {if $system['pages_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
                  <option value="everyone" {if $system['pages_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
                </select>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="groups" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Groups")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the groups On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="groups_enabled">
                  <input type="checkbox" name="groups_enabled" id="groups_enabled" {if $system['groups_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Who Can Create Groups")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="groups_permission">
                  <option value="admins" {if $system['groups_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
                  <option value="pro" {if $system['groups_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
                  <option value="verified" {if $system['groups_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
                  <option value="everyone" {if $system['groups_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
                </select>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="events" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Events")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the events On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="events_enabled">
                  <input type="checkbox" name="events_enabled" id="events_enabled" {if $system['events_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Who Can Create Events")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="events_permission">
                  <option value="admins" {if $system['events_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
                  <option value="pro" {if $system['events_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
                  <option value="verified" {if $system['events_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
                  <option value="everyone" {if $system['events_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
                </select>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="blogs" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Blogs")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the blogs On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="blogs_enabled">
                  <input type="checkbox" name="blogs_enabled" id="blogs_enabled" {if $system['blogs_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Who Can Write Articles")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="blogs_permission">
                  <option value="admins" {if $system['blogs_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
                  <option value="pro" {if $system['blogs_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
                  <option value="verified" {if $system['blogs_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
                  <option value="everyone" {if $system['blogs_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
                </select>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="market" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Marketplace")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the marketplace On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="market_enabled">
                  <input type="checkbox" name="market_enabled" id="market_enabled" {if $system['market_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Who Can Sell Products")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="market_permission">
                  <option value="admins" {if $system['market_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
                  <option value="pro" {if $system['market_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
                  <option value="verified" {if $system['market_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
                  <option value="everyone" {if $system['market_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
                </select>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="offers" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Offers")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Turn the offers On and Off")}<br>
                  {__("Only pages can publish offers (Pages must be enabled too)")}
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="offers_enabled">
                  <input type="checkbox" name="offers_enabled" id="offers_enabled" {if $system['offers_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="jobs" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Jobs")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Turn the jobs On and Off")}<br>
                  {__("Only pages can publish jobs (Pages must be enabled too)")}
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="jobs_enabled">
                  <input type="checkbox" name="jobs_enabled" id="jobs_enabled" {if $system['jobs_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="forums" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Forums")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the forums On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="forums_enabled">
                  <input type="checkbox" name="forums_enabled" id="forums_enabled" {if $system['forums_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="user_online" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Online Users")}</div>
                <div class="form-text d-none d-sm-block">{__("Show forums online users")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="forums_online_enabled">
                  <input type="checkbox" name="forums_online_enabled" id="forums_online_enabled" {if $system['forums_online_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="stats" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Statistics")}</div>
                <div class="form-text d-none d-sm-block">{__("Show forums statistics")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="forums_statistics_enabled">
                  <input type="checkbox" name="forums_statistics_enabled" id="forums_statistics_enabled" {if $system['forums_statistics_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Who Can Add Threads/Replies")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="forums_permission">
                  <option value="admins" {if $system['forums_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
                  <option value="pro" {if $system['forums_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
                  <option value="verified" {if $system['forums_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
                  <option value="everyone" {if $system['forums_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
                </select>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="movies" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Movies")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the movies On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="movies_enabled">
                  <input type="checkbox" name="movies_enabled" id="movies_enabled" {if $system['movies_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Who Can Watch Movies")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="movies_permission">
                  <option value="admins" {if $system['movies_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
                  <option value="pro" {if $system['movies_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
                  <option value="verified" {if $system['movies_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
                  <option value="everyone" {if $system['movies_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
                </select>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="games" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Games")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the games On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="games_enabled">
                  <input type="checkbox" name="games_enabled" id="games_enabled" {if $system['games_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Who Can Play Games")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="games_permission">
                  <option value="admins" {if $system['games_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
                  <option value="pro" {if $system['games_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
                  <option value="verified" {if $system['games_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
                  <option value="everyone" {if $system['games_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
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
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- Modules -->

      <!-- Features -->
      <div class="tab-pane" id="Features">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=features">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="map" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Fliter by Location")}</div>
                <div class="form-text d-none d-sm-block">{__("If enabled user will able to filter people, products, jobs & offers by location")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="location_finder_enabled">
                  <input type="checkbox" name="location_finder_enabled" id="location_finder_enabled" {if $system['location_finder_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="contat_us" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Contact Us")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the contact us page On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="contact_enabled">
                  <input type="checkbox" name="contact_enabled" id="contact_enabled" {if $system['contact_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="night" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("DayTime Messages")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the DayTime Messages (Good Morning, Afternoon, Evening) On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="daytime_msg_enabled">
                  <input type="checkbox" name="daytime_msg_enabled" id="daytime_msg_enabled" {if $system['daytime_msg_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="poke" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Pokes")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable users to poke each others")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="pokes_enabled">
                  <input type="checkbox" name="pokes_enabled" id="pokes_enabled" {if $system['pokes_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="gifts" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Gifts")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Enable users to send gifts to each others")}<br>
                  {__("Make sure you have configured")} <a href="{$system['system_url']}/{$control_panel['url']}/gifts">{__("Gifts")}</a>
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="gifts_enabled">
                  <input type="checkbox" name="gifts_enabled" id="gifts_enabled" {if $system['gifts_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="cookie" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Cookie Consent")} ({__("GDPR")})</div>
                <div class="form-text d-none d-sm-block">{__("Turn the cookie consent notification On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="cookie_consent_enabled">
                  <input type="checkbox" name="cookie_consent_enabled" id="cookie_consent_enabled" {if $system['cookie_consent_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="adblock" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Adblock Detector")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Turn the Adblock auto detector notification On and Off")}, {__("(Note: Admin is exception)")}<br>
                  {__("Red block message will appear to make user disable adblock from his browser")}<br>
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="adblock_detector_enabled">
                  <input type="checkbox" name="adblock_detector_enabled" id="adblock_detector_enabled" {if $system['adblock_detector_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
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
      </div>
      <!-- Features -->
    </div>
    <!-- tab-content -->

  {elseif $sub_view == "posts"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Posts")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Posts -->
    <form class="js_ajax-forms" data-url="admin/settings.php?edit=posts">
      <div class="card-body">
        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="24_hours" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6 mb5">{__("Stories")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the stories On and Off")}<br>
              {__("Stories are photos and videos that only last 24 hours")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="stories_enabled">
              <input type="checkbox" name="stories_enabled" id="stories_enabled" {if $system['stories_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Story Duration")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="stories_duration" value="{$system['stories_duration']}">
            <span class="form-text">
              {__("The story duration in seconds")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Who Can Add Stories")}
          </label>
          <div class="col-md-9">
            <select class="form-control selectpicker" name="stories_permission">
              <option value="admins" {if $system['stories_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
              <option value="pro" {if $system['stories_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
              <option value="verified" {if $system['stories_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
              <option value="everyone" {if $system['stories_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
            </select>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Newsfeed Posts Source")}
          </label>
          <div class="col-md-9">
            <select class="form-control selectpicker" name="newsfeed_source">
              <option value="default" {if $system['newsfeed_source'] == "default"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-users fa-lg fa-fw'></i></div><div class='text'><b>{__("Default")}<span class='d-none d-md-inline'><br>{__("Show what user is followings (Friends, Followings, Pages... etc)")}</span></div></div>">{__("Default")}</option>
              <option value="all_posts" {if $system['newsfeed_source'] == "all_posts"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("All Posts")}<span class='d-none d-md-inline'><br>{__("All posts will be shown")}</span></div></div>">{__("All Posts")}</option>
            </select>
            <span class="form-text">
              {__("Algorithm will exclude any post from closed/secret groups and events that users not member of incase of all posts also will disable all posts privacy")}
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="popularity" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Popular Posts")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the popular posts On and Off")}<br>
              {__("Popular posts are public posts ordered by most reactions, comments & shares")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="popular_posts_enabled">
              <input type="checkbox" name="popular_posts_enabled" id="popular_posts_enabled" {if $system['popular_posts_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="posts_discover" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Discover Posts")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the discover posts On and Off")}<br>
              {__("Discover posts are public posts ordered from most recent to old")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="discover_posts_enabled">
              <input type="checkbox" name="discover_posts_enabled" id="discover_posts_enabled" {if $system['discover_posts_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="memories" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6 mb5">{__("Memories")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the memories On and Off")}<br>
              {__("Memories are posts from the same day on last year")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="memories_enabled">
              <input type="checkbox" name="memories_enabled" id="memories_enabled" {if $system['memories_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="wall_posts" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Wall Posts")}</div>
            <div class="form-text d-none d-sm-block">{__("Users can publish posts on their friends walls")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="wall_posts_enabled">
              <input type="checkbox" name="wall_posts_enabled" id="wall_posts_enabled" {if $system['wall_posts_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="posts_colored" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Colored Posts")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the colored posts On and Off")}<br>
              {__("Make sure you have configured")} <a href="{$system['system_url']}/{$control_panel['url']}/colored_posts">{__("Colored Posts")}</a>
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="colored_posts_enabled">
              <input type="checkbox" name="colored_posts_enabled" id="colored_posts_enabled" {if $system['colored_posts_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="smile" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Feelings/Activity Posts")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the feelings and activity posts On and Off")}<br>
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="activity_posts_enabled">
              <input type="checkbox" name="activity_posts_enabled" id="activity_posts_enabled" {if $system['activity_posts_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="voice_notes" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Voice Notes in Posts")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the voice notes in posts On and Off")}<br>
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="voice_notes_posts_enabled">
              <input type="checkbox" name="voice_notes_posts_enabled" id="voice_notes_posts_enabled" {if $system['voice_notes_posts_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            <div style="width: 40px; height: 40px;"></div>
          </div>
          <div>
            <div class="form-control-label h6">{__("Voice Notes in Comments")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the voice notes in comments On and Off")}<br>
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="voice_notes_comments_enabled">
              <input type="checkbox" name="voice_notes_comments_enabled" id="voice_notes_comments_enabled" {if $system['voice_notes_comments_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Voice Notes Max Duration")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="voice_notes_durtaion" value="{$system['voice_notes_durtaion']}">
            <span class="form-text">
              {__("The maximum length for voice note in seconds")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Voice Notes Encoding")}
          </label>
          <div class="col-md-9">
            <select class="form-control" name="voice_notes_encoding">
              <option value="mp3" {if $system['voice_notes_encoding'] == "mp3"}selected{/if}>mp3</option>
              <option value="ogg" {if $system['voice_notes_encoding'] == "ogg"}selected{/if}>ogg</option>
              <option value="wav" {if $system['voice_notes_encoding'] == "wav"}selected{/if}>wav</option>
            </select>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="polls" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Polls")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the poll posts On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="polls_enabled">
              <input type="checkbox" name="polls_enabled" id="polls_enabled" {if $system['polls_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="map" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Geolocation")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the post Geolocation On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="geolocation_enabled">
              <input type="checkbox" name="geolocation_enabled" id="geolocation_enabled" {if $system['geolocation_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Geolocation Google Key")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="geolocation_key" value="{$system['geolocation_key']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
            <span class="form-text">
              {__("Check the documentation to learn how to get this key")}
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="gif" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("GIF")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the gif posts On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="gif_enabled">
              <input type="checkbox" name="gif_enabled" id="gif_enabled" {if $system['gif_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Giphy API Key")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="giphy_key" value="{$system['giphy_key']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
            <span class="form-text">
              {__("Check the documentation to learn how to get this key")}
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="language" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Post Translation")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the post translation On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="post_translation_enabled">
              <input type="checkbox" name="post_translation_enabled" id="post_translation_enabled" {if $system['post_translation_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Yandex Key")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="yandex_key" value="{$system['yandex_key']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
            <span class="form-text">
              {__("Check the documentation to learn how to get this key")}
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="youtube" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Smart YouTube Player")}</div>
            <div class="form-text d-none d-sm-block">{__("Smart YouTube player will save a lot of bandwidth")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="smart_yt_player">
              <input type="checkbox" name="smart_yt_player" id="smart_yt_player" {if $system['smart_yt_player']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="social_share" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Social Media Share")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the social media share for posts On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="social_share_enabled">
              <input type="checkbox" name="social_share_enabled" id="social_share_enabled" {if $system['social_share_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Max Post Characters")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="max_post_length" value="{$system['max_post_length']}">
            <span class="form-text">
              {__("The Maximum allowed post characters length (0 for unlimited)")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Max Comment Characters")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="max_comment_length" value="{$system['max_comment_length']}">
            <span class="form-text">
              {__("The Maximum allowed comment characters length (0 for unlimited)")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Max Posts/Hour")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="max_posts_hour" value="{$system['max_posts_hour']}">
            <span class="form-text">
              {__("The Maximum number of posts that user can publish per hour (0 for unlimited)")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Max Comments/Hour")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="max_comments_hour" value="{$system['max_comments_hour']}">
            <span class="form-text">
              {__("The Maximum number of comments that user can publish per hour (0 for unlimited)")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Default Posts Privacy")}
          </label>
          <div class="col-md-9">
            <select class="form-control selectpicker" name="default_privacy">
              <option value="public" {if $system['default_privacy'] == "public"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Public")}<span class='d-none d-md-inline'><br>{__("Anyone one can see the post")}</span></div></div>">{__("Public")}</option>
              <option value="friends" {if $system['default_privacy'] == "friends"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-users fa-lg fa-fw'></i></div><div class='text'><b>{__("Friends")}<span class='d-none d-md-inline'><br>{__("Only post author friends can see the post")}</span></div></div>">{__("Friends")}</option>
              <option value="me" {if $system['default_privacy'] == "me"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Only Me")}<span class='d-none d-md-inline'><br>{__("Only post author can see the post")}</span></div></div>">{__("Only Me")}</option>
            </select>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="spy" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6 mb5">{__("Post As Anonymous")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn Anonymous mode On and Off")}<br>
              {__("Note: Admins and Moderators will able to see the real post author")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="anonymous_mode">
              <input type="checkbox" name="anonymous_mode" id="anonymous_mode" {if $system['anonymous_mode']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="user_online" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6 mb5">{__("Online Status on Posts")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn online indicator on Posts On and Off (User must be online and enabled the chat)")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="posts_online_status">
              <input type="checkbox" name="posts_online_status" id="posts_online_status" {if $system['posts_online_status']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="scroll_desktop" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6 mb5">{__("Desktop Infinite Scroll")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn infinite scroll on desktop screens On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="desktop_infinite_scroll">
              <input type="checkbox" name="desktop_infinite_scroll" id="desktop_infinite_scroll" {if $system['desktop_infinite_scroll']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="scroll_mobile" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6 mb5">{__("Mobile Infinite Scroll")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn infinite scroll on mobile screens On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="mobile_infinite_scroll">
              <input type="checkbox" name="mobile_infinite_scroll" id="mobile_infinite_scroll" {if $system['mobile_infinite_scroll']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="videos" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6 mb5">{__("Auto Play Videos")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn auto play videos On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="auto_play_videos">
              <input type="checkbox" name="auto_play_videos" id="auto_play_videos" {if $system['auto_play_videos']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="trending" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6 mb5">{__("Trending Hashtags")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the trending hashtags feature On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="trending_hashtags_enabled">
              <input type="checkbox" name="trending_hashtags_enabled" id="trending_hashtags_enabled" {if $system['trending_hashtags_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Trending Interval")}
          </label>
          <div class="col-md-9">
            <select class="form-control" name="trending_hashtags_interval">
              <option {if $system['trending_hashtags_interval'] == "day"}selected{/if} value="day">{__("Last 24 Hours")}</option>
              <option {if $system['trending_hashtags_interval'] == "week"}selected{/if} value="week">{__("Last Week")}</option>
              <option {if $system['trending_hashtags_interval'] == "month"}selected{/if} value="month">{__("Last Month")}</option>
            </select>
            <span class="form-text">
              {__("Select the interval of trending hashtags")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Hashtags Limit")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="trending_hashtags_limit" value="{$system['trending_hashtags_limit']}">
            <span class="form-text">
              {__("How many hashtags you want to display")}
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
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>
    <!-- Posts -->

  {elseif $sub_view == "registration"}

    <!-- card-header -->
    <div class="card-header with-icon with-nav">
      <!-- panel title -->
      <div class="mb20">
        <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Registration")}
      </div>
      <!-- panel title -->

      <!-- panel nav -->
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link active" href="#General" data-toggle="tab">
            <i class="fa fa-sign-in-alt fa-fw mr5"></i><strong>{__("General")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Social" data-toggle="tab">
            <i class="fab fa-facebook fa-fw mr5"></i><strong>{__("Social Login")}</strong>
          </a>
        </li>
      </ul>
      <!-- panel nav -->
    </div>
    <!-- card-header -->

    <!-- tabs content -->
    <div class="tab-content">
      <!-- General -->
      <div class="tab-pane active" id="General">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=registration">
          <div class="card-body">
            <div class="alert alert-info">
              <div class="icon">
                <i class="fa fa-info-circle fa-2x"></i>
              </div>
              <div class="text pt5">
                {__("If Registration is Free and Pro Packages enabled they will be used as optional upgrading plans")}.
              </div>
            </div>
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="registration" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Registration")}</div>
                <div class="form-text d-none d-sm-block">{__("Allow users to create accounts")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="registration_enabled">
                  <input type="checkbox" name="registration_enabled" id="registration_enabled" {if $system['registration_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Registration Type")}
              </label>
              <div class="col-md-9">
                <div class="custom-control custom-radio custom-control-inline">
                  <input type="radio" name="registration_type" id="registration_free" value="free" class="custom-control-input" {if $system['registration_type'] == "free"}checked{/if}>
                  <label class="custom-control-label" for="registration_free">{__("Free")}</label>
                </div>
                <div class="custom-control custom-radio custom-control-inline">
                  <input type="radio" name="registration_type" id="registration_paid" value="paid" class="custom-control-input" {if $system['registration_type'] == "paid"}checked{/if}>
                  <label class="custom-control-label" for="registration_paid">{__("Subscriptions Only")}</label>
                </div>
                <span class="form-text">
                  {__("Allow users to create accounts Free or via Subscriptions only")}<br>
                  {__("Make sure you have configured")} <a href="{$system['system_url']}/{$control_panel['url']}/pro">{__("Pro System")}</a>
                </span>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="invitation" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Invitation System")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("This option is used to register the users by invitation codes only")}
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="invitation_enabled">
                  <input type="checkbox" name="invitation_enabled" id="invitation_enabled" {if $system['invitation_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Who Can Generate Invitation Codes")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="invitation_permission">
                  <option value="admins" {if $system['invitation_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
                  <option value="pro" {if $system['invitation_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
                  <option value="verified" {if $system['invitation_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
                  <option value="everyone" {if $system['invitation_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
                </select>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Invitations/User")}
              </label>
              <div class="col-md-9">
                <div class="form-row">
                  <div class="col-sm-8">
                    <input class="form-control" name="invitation_user_limit" value="{$system['invitation_user_limit']}">
                  </div>
                  <div class="col-sm-4">
                    <select class="form-control" name="invitation_expire_period">
                      <option {if $system['invitation_expire_period'] == "hour"}selected{/if} value="hour">{__("Hour")}</option>
                      <option {if $system['invitation_expire_period'] == "day"}selected{/if} value="day">{__("Day")}</option>
                      <option {if $system['invitation_expire_period'] == "week"}selected{/if} value="week">{__("Week")}</option>
                      <option {if $system['invitation_expire_period'] == "month"}selected{/if} value="month">{__("Month")}</option>
                      <option {if $system['invitation_expire_period'] == "year"}selected{/if} value="year">{__("Year")}</option>
                    </select>
                  </div>
                </div>
                <span class="form-text">
                  {__("Number of invitation codes allowed to each user (0 for unlimited) ")}<br>
                  {__("For example 1 code per day, 5 codes per month")}

                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Send Method")}
              </label>
              <div class="col-md-9">
                <div class="custom-control custom-radio custom-control-inline">
                  <input type="radio" name="invitation_send_method" id="invitation_email" value="email" class="custom-control-input" {if $system['invitation_send_method'] == "email"}checked{/if}>
                  <label class="custom-control-label" for="invitation_email">{__("Email")}</label>
                </div>
                <div class="custom-control custom-radio custom-control-inline">
                  <input type="radio" name="invitation_send_method" id="invitation_sms" value="sms" class="custom-control-input" {if $system['invitation_send_method'] == "sms"}checked{/if}>
                  <label class="custom-control-label" for="invitation_sms">{__("SMS")}</label>
                </div>
                <div class="custom-control custom-radio custom-control-inline">
                  <input type="radio" name="invitation_send_method" id="invitation_both" value="both" class="custom-control-input" {if $system['invitation_send_method'] == "both"}checked{/if}>
                  <label class="custom-control-label" for="invitation_both">{__("Both")}</label>
                </div>
                <span class="form-text">
                  {__("Select Email or SMS to send invitation link to new user's email/phone")}<br>
                  {__("Make sure you have configured")} <a href="{$system['system_url']}/{$control_panel['url']}/settings/sms">{__("SMS Settings")}</a>
                </span>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="account_activation" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Activation Enabled")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable account activation to send activation code to user's email/phone")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="activation_enabled">
                  <input type="checkbox" name="activation_enabled" id="activation_enabled" {if $system['activation_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="adblock" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Activation Required")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable this and user will not be able to access without activation")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="activation_required">
                  <input type="checkbox" name="activation_required" id="activation_required" {if $system['activation_required']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Activation Type")}
              </label>
              <div class="col-md-9">
                <div class="custom-control custom-radio custom-control-inline">
                  <input type="radio" name="activation_type" id="activation_email" value="email" class="custom-control-input" {if $system['activation_type'] == "email"}checked{/if}>
                  <label class="custom-control-label" for="activation_email">{__("Email")}</label>
                </div>
                <div class="custom-control custom-radio custom-control-inline">
                  <input type="radio" name="activation_type" id="activation_sms" value="sms" class="custom-control-input" {if $system['activation_type'] == "sms"}checked{/if}>
                  <label class="custom-control-label" for="activation_sms">{__("SMS")}</label>
                </div>
                <span class="form-text">
                  {__("Select Email or SMS activation to send activation code to user's email/phone")}<br>
                  {__("Make sure you have configured")} <a href="{$system['system_url']}/{$control_panel['url']}/settings/sms">{__("SMS Settings")}</a>
                </span>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="age_limit" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Age Restriction")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable/Disable age restriction")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="age_restriction">
                  <input type="checkbox" name="age_restriction" id="age_restriction" {if $system['age_restriction']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Minimum Age")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="minimum_age" value="{$system['minimum_age']}">
                <span class="form-text">
                  {__("The minimum age required to register (in years)")}
                </span>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="getting_started" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Getting Started")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable/Disable getting started page after registration")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="getting_started">
                  <input type="checkbox" name="getting_started" id="getting_started" {if $system['getting_started']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="newsletter" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Newsletter Consent")} ({__("GDPR")})</div>
                <div class="form-text d-none d-sm-block">{__("Enable/Disable newsletter consent during the registration")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="newsletter_consent">
                  <input type="checkbox" name="newsletter_consent" id="newsletter_consent" {if $system['newsletter_consent']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Max Accounts/IP")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="max_accounts" value="{$system['max_accounts']}">
                <span class="form-text">
                  {__("The Maximum number of accounts allowed to register per IP (0 for unlimited)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Name Minimum Length")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="name_min_length" value="{$system['name_min_length']}">
                <span class="form-text">
                  {__("The First and Last name minimum length")}
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
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- General -->

      <!-- Social -->
      <div class="tab-pane" id="Social">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=social_login">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="social_share" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Social Logins")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn registration/login via social media (Facebook, Twitter and etc) On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="social_login_enabled">
                  <input type="checkbox" name="social_login_enabled" id="social_login_enabled" {if $system['social_login_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <!-- facebook -->
            <div class="form-table-row">
              <div class="avatar">
                <i class="fab fa-facebook-square fa-3x" style="color: #3B579D"></i>
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Facebook")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn registration/login via Facebook On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="facebook_login_enabled">
                  <input type="checkbox" name="facebook_login_enabled" id="facebook_login_enabled" {if $system['facebook_login_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Facebook App ID")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="facebook_appid" value="{$system['facebook_appid']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Facebook App Secret")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="facebook_secret" value="{$system['facebook_secret']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>
            <!-- facebook -->

            <div class="divider"></div>

            <!-- google -->
            <div class="form-table-row">
              <div class="avatar">
                <i class="fab fa-google fa-3x" style="color: #DC4A38"></i>
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Google")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn registration/login via Google On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="google_login_enabled">
                  <input type="checkbox" name="google_login_enabled" id="google_login_enabled" {if $system['google_login_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Google App ID")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="google_appid" value="{$system['google_appid']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Google App Secret")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="google_secret" value="{$system['google_secret']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>
            <!-- google -->

            <div class="divider"></div>

            <!-- twitter -->
            <div class="form-table-row">
              <div class="avatar">
                <i class="fab fa-twitter-square fa-3x" style="color: #55ACEE"></i>
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Twitter")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn registration/login via Twitter On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="twitter_login_enabled">
                  <input type="checkbox" name="twitter_login_enabled" id="twitter_login_enabled" {if $system['twitter_login_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Twitter App ID")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="twitter_appid" value="{$system['twitter_appid']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Twitter App Secret")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="twitter_secret" value="{$system['twitter_secret']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>
            <!-- twitter -->

            <div class="divider"></div>

            <!-- linkedin -->
            <div class="form-table-row">
              <div class="avatar">
                <i class="fab fa-linkedin fa-3x" style="color: #1A84BC"></i>
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Linkedin")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn registration/login via Linkedin On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="linkedin_login_enabled">
                  <input type="checkbox" name="linkedin_login_enabled" id="linkedin_login_enabled" {if $system['linkedin_login_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Linkedin App ID")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="linkedin_appid" value="{$system['linkedin_appid']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Linkedin App Secret")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="linkedin_secret" value="{$system['linkedin_secret']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>
            <!-- linkedin -->

            <div class="divider"></div>

            <!-- vk -->
            <div class="form-table-row">
              <div class="avatar">
                <i class="fab fa-vk fa-3x" style="color: #527498"></i>
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Vkontakte")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn registration/login via Vkontakte On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="vkontakte_login_enabled">
                  <input type="checkbox" name="vkontakte_login_enabled" id="vkontakte_login_enabled" {if $system['vkontakte_login_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Vkontakte App ID")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="vkontakte_appid" value="{$system['vkontakte_appid']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Vkontakte App Secret")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="vkontakte_secret" value="{$system['vkontakte_secret']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>
            <!-- vk -->

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
      </div>
      <!-- Social -->
    </div>
    <!-- tabs content -->

  {elseif $sub_view == "accounts"}

    <!-- card-header -->
    <div class="card-header with-icon with-nav">
      <!-- panel title -->
      <div class="mb20">
        <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Accounts")}
      </div>
      <!-- panel title -->

      <!-- panel nav -->
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link active" href="#General" data-toggle="tab">
            <i class="fa fa-user-cog fa-fw mr5"></i><strong>{__("General")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Profile" data-toggle="tab">
            <i class="fa fa-address-card fa-fw mr5"></i><strong>{__("Profile")}</strong>
          </a>
        </li>
      </ul>
      <!-- panel nav -->
    </div>
    <!-- card-header -->

    <!-- tab-content -->
    <div class="tab-content">
      <!-- General -->
      <div class="tab-pane active" id="General">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=accounts">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="username" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Show Usernames Only")}</div>
                <div class="form-text d-none d-sm-block">{__("If disabled full names will be displayed instead")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="show_usernames_enabled">
                  <input type="checkbox" name="show_usernames_enabled" id="show_usernames_enabled" {if $system['show_usernames_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="delete_user" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Delete Account")} ({__("GDPR")})</div>
                <div class="form-text d-none d-sm-block">{__("Allow users to delete their account")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="delete_accounts_enabled">
                  <input type="checkbox" name="delete_accounts_enabled" id="delete_accounts_enabled" {if $system['delete_accounts_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="info_download" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Download User Information")} ({__("GDPR")})</div>
                <div class="form-text d-none d-sm-block">{__("Allow users to download their account information from settings page")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="download_info_enabled">
                  <input type="checkbox" name="download_info_enabled" id="download_info_enabled" {if $system['download_info_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="verification" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Verification Requests")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the verification requests from users & pages On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="verification_requests">
                  <input type="checkbox" name="verification_requests" id="verification_requests" {if $system['verification_requests']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="followings" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Disable Friend Request After Decline")}</div>
                <div class="form-text d-none d-sm-block">{__("If enabled user A will be able to send friendship request to user B again")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="disable_declined_friendrequest">
                  <input type="checkbox" name="disable_declined_friendrequest" id="disable_declined_friendrequest" {if $system['disable_declined_friendrequest']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Max Friends/User")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="max_friends" value="{$system['max_friends']}">
                <span class="form-text">
                  {__("The Maximum number of friends allowed per User (0 for unlimited)")}
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
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- General -->

      <!-- Profile -->
      <div class="tab-pane" id="Profile">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=profile">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="relationship" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Relationship Status")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the Relationship Status On/Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="relationship_info_enabled">
                  <input type="checkbox" name="relationship_info_enabled" id="relationship_info_enabled" {if $system['relationship_info_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="website" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Website")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the Website On/Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="website_info_enabled">
                  <input type="checkbox" name="website_info_enabled" id="website_info_enabled" {if $system['website_info_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="biography" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("About Me")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the About Me On/Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="biography_info_enabled">
                  <input type="checkbox" name="biography_info_enabled" id="biography_info_enabled" {if $system['biography_info_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="work" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Work Info")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the Work info On/Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="work_info_enabled">
                  <input type="checkbox" name="work_info_enabled" id="work_info_enabled" {if $system['work_info_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="location" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Location Info")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the Location info On/Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="location_info_enabled">
                  <input type="checkbox" name="location_info_enabled" id="location_info_enabled" {if $system['location_info_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="education" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Education Info")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the Education info On/Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="education_info_enabled">
                  <input type="checkbox" name="education_info_enabled" id="education_info_enabled" {if $system['education_info_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="social_share" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Social Links")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the Social Links On/Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="social_info_enabled">
                  <input type="checkbox" name="social_info_enabled" id="social_info_enabled" {if $system['social_info_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="design" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Profile Design")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Allow users to upload background image to their profiles")}
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="system_profile_background_enabled">
                  <input type="checkbox" name="system_profile_background_enabled" id="system_profile_background_enabled" {if $system['system_profile_background_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
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
      </div>
      <!-- Profile -->
    </div>
    <!-- tab-content -->

  {elseif $sub_view == "email"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Email")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <form class="js_ajax-forms" data-url="admin/settings.php?edit=email">
      <div class="card-body">
        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="email_smtp" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("SMTP")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Enable/Disable SMTP email system")}<br />
              {__("PHP mail() function will be used in case of disabled")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="email_smtp_enabled">
              <input type="checkbox" name="email_smtp_enabled" id="email_smtp_enabled" {if $system['email_smtp_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="login" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("SMTP Require Authentication")}</div>
            <div class="form-text d-none d-sm-block">{__("Enable/Disable SMTP authentication")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="email_smtp_authentication">
              <input type="checkbox" name="email_smtp_authentication" id="email_smtp_authentication" {if $system['email_smtp_authentication']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="ssl" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("SMTP SSL Encryption")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Enable/Disable SMTP SSL encryption")}<br />
              {__("TLS encryption will be used in case of disabled")}
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="email_smtp_ssl">
              <input type="checkbox" name="email_smtp_ssl" id="email_smtp_ssl" {if $system['email_smtp_ssl']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("SMTP Server")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="email_smtp_server" value="{$system['email_smtp_server']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("SMTP Port")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="email_smtp_port" value="{$system['email_smtp_port']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("SMTP Username")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="email_smtp_username" value="{$system['email_smtp_username']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("SMTP Password")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="email_smtp_password" value="{$system['email_smtp_password']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Set From")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="email_smtp_setfrom" value="{$system['email_smtp_setfrom']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
            <span class="form-text">
              {__("Set the From email address")}, {__("For example: email@domain.com")}
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
        <button type="button" class="btn btn-danger js_admin-tester" data-handle="smtp">
          <i class="fa fa-bolt mr10"></i>{__("Test Connection")}
        </button>
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>

  {elseif $sub_view == "sms"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("SMS")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- SMS -->
    <form class="js_ajax-forms" data-url="admin/settings.php?edit=sms">
      <div class="card-body">

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("SMS Provider")}
          </label>
          <div class="col-md-9">
            <div>
              <!-- Twilio -->
              <input class="x-hidden input-label" type="radio" name="sms_provider" value="twilio" id="sms_twilio" {if $system['sms_provider'] == "twilio"}checked{/if} />
              <label class="button-label" for="sms_twilio">
                <div class="icon">
                  {include file='__svg_icons.tpl' icon="twilio" width="32px" height="32px"}
                </div>
                <div class="title">{__("Twilio")}</div>
              </label>
              <!-- Twilio -->
              <!-- BulkSMS -->
              <input class="x-hidden input-label" type="radio" name="sms_provider" value="bulksms" id="sms_bulksms" {if $system['sms_provider'] == "bulksms"}checked{/if} />
              <label class="button-label" for="sms_bulksms">
                <div class="icon">
                  {include file='__svg_icons.tpl' icon="bulksms" width="52px" height="32px"}
                </div>
                <div class="title">{__("BulkSMS")}</div>
              </label>
              <!-- BulkSMS -->
              <!-- Infobip -->
              <input class="x-hidden input-label" type="radio" name="sms_provider" value="infobip" id="sms_infobip" {if $system['sms_provider'] == "infobip"}checked{/if} />
              <label class="button-label" for="sms_infobip">
                <div class="icon">
                  {include file='__svg_icons.tpl' icon="infobip" width="52px" height="32px"}
                </div>
                <div class="title">{__("Infobip")}</div>
              </label>
              <!-- Infobip -->
              <!-- Msg91 -->
              <input class="x-hidden input-label" type="radio" name="sms_provider" value="msg91" id="sms_msg91" {if $system['sms_provider'] == "msg91"}checked{/if} />
              <label class="button-label" for="sms_msg91">
                <div class="icon">
                  {include file='__svg_icons.tpl' icon="msg91" width="52px" height="32px"}
                </div>
                <div class="title">{__("Msg91")}</div>
              </label>
              <!-- Msg91 -->
            </div>

            <span class="form-text">
              {__("Select your default SMS provider")}<br />
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <!-- Twilio -->
        <div class="heading-small mb20">
          {__("Twilio")}
        </div>
        <div class="pl-md-4">
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Twilio Account SID")}
            </label>
            <div class="col-md-9">
              {if !$user->_data['user_demo']}
                <input type="text" class="form-control" name="twilio_sid" value="{$system['twilio_sid']}">
              {else}
                <input type="password" class="form-control" value="*********">
              {/if}
            </div>
          </div>

          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Twilio Auth Token")}
            </label>
            <div class="col-md-9">
              {if !$user->_data['user_demo']}
                <input type="text" class="form-control" name="twilio_token" value="{$system['twilio_token']}">
              {else}
                <input type="password" class="form-control" value="*********">
              {/if}
            </div>
          </div>

          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Twilio Phone Number")}
            </label>
            <div class="col-md-9">
              {if !$user->_data['user_demo']}
                <input type="text" class="form-control" name="twilio_phone" value="{$system['twilio_phone']}">
              {else}
                <input type="password" class="form-control" value="*********">
              {/if}
            </div>
          </div>
        </div>
        <!-- Twilio -->

        <div class="divider"></div>

        <!-- BulkSMS -->
        <div class="heading-small mb20">
          {__("BulkSMS")}
        </div>
        <div class="pl-md-4">
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("BulkSMS Username")}
            </label>
            <div class="col-md-9">
              {if !$user->_data['user_demo']}
                <input type="text" class="form-control" name="bulksms_username" value="{$system['bulksms_username']}">
              {else}
                <input type="password" class="form-control" value="*********">
              {/if}
            </div>
          </div>

          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("BulkSMS Password")}
            </label>
            <div class="col-md-9">
              {if !$user->_data['user_demo']}
                <input type="text" class="form-control" name="bulksms_password" value="{$system['bulksms_password']}">
              {else}
                <input type="password" class="form-control" value="*********">
              {/if}
            </div>
          </div>
        </div>
        <!-- BulkSMS -->

        <div class="divider"></div>

        <!-- Infobip -->
        <div class="heading-small mb20">
          {__("Infobip")}
        </div>
        <div class="pl-md-4">
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Infobip Username")}
            </label>
            <div class="col-md-9">
              {if !$user->_data['user_demo']}
                <input type="text" class="form-control" name="infobip_username" value="{$system['infobip_username']}">
              {else}
                <input type="password" class="form-control" value="*********">
              {/if}
            </div>
          </div>

          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Infobip Password")}
            </label>
            <div class="col-md-9">
              {if !$user->_data['user_demo']}
                <input type="text" class="form-control" name="infobip_password" value="{$system['infobip_password']}">
              {else}
                <input type="password" class="form-control" value="*********">
              {/if}
            </div>
          </div>
        </div>
        <!-- Infobip -->

        <div class="divider"></div>

        <!-- Msg91 -->
        <div class="heading-small mb20">
          {__("Msg91")}
        </div>
        <div class="pl-md-4">
          <div class="form-group form-row">
            <label class="col-md-3 form-control-label">
              {__("Msg91 AuthKey")}
            </label>
            <div class="col-md-9">
              {if !$user->_data['user_demo']}
                <input type="text" class="form-control" name="msg91_authkey" value="{$system['msg91_authkey']}">
              {else}
                <input type="password" class="form-control" value="*********">
              {/if}
            </div>
          </div>
        </div>
        <!-- Msg91 -->

        <div class="divider"></div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Test Phone Number")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="system_phone" value="{$system['system_phone']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
            <span class="form-text">
              {__("Your phone number to test the SMS service i.e +12344567890")}<br />
              {__("A test SMS will be sent to this phone number when you test the connection")}
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
        <button type="button" class="btn btn-danger js_admin-tester" data-handle="sms">
          <i class="fa fa-bolt mr10"></i>{__("Test Connection")}
        </button>
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>
    <!-- SMS -->

  {elseif $sub_view == "notifications"}

    <!-- card-header -->
    <div class="card-header with-icon with-nav">
      <!-- panel title -->
      <div class="mb20">
        <i class="fa fa-bell mr10"></i>{__("Settings")} &rsaquo; {__("Notifications")}
      </div>
      <!-- panel title -->

      <!-- panel nav -->
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link active" href="#Website" data-toggle="tab">
            <i class="fa fa-bell fa-fw mr5"></i><strong>{__("Website Notifications")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Email" data-toggle="tab">
            <i class="fa fa-envelope fa-fw mr5"></i><strong>{__("Email Notifications")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Push" data-toggle="tab">
            <i class="fas fa-broadcast-tower fa-fw mr5"></i><strong>{__("Push Notifications")}</strong>
          </a>
        </li>
      </ul>
      <!-- panel nav -->
    </div>
    <!-- card-header -->

    <!-- tabs content -->
    <div class="tab-content">
      <!-- Website Notifications -->
      <div class="tab-pane active" id="Website">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=website_notifications">
          <div class="card-body">

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="profile_notifications" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Profile Visit Notification")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the profile visit notification On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="profile_notification_enabled">
                  <input type="checkbox" name="profile_notification_enabled" id="profile_notification_enabled" {if $system['profile_notification_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="browser_notifications" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Browser Notifications")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the browser notifications On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="browser_notifications_enabled">
                  <input type="checkbox" name="browser_notifications_enabled" id="browser_notifications_enabled" {if $system['browser_notifications_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="noty_notifications" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Noty Notifications")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Turn the noty notifications On and Off")} (<a target="_blank" href="{$system['system_url']}/content/themes/{$system['theme']}/images/screenshots/noty_notification.png">{__("preview")}</a>)
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="noty_notifications_enabled">
                  <input type="checkbox" name="noty_notifications_enabled" id="noty_notifications_enabled" {if $system['noty_notifications_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
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
      </div>
      <!-- Website Notifications -->

      <!-- Email Notifications -->
      <div class="tab-pane" id="Email">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=email_notifications">
          <div class="card-body">

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="email_notifications" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Email Notifications")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable/Disable email notifications system")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="email_notifications">
                  <input type="checkbox" name="email_notifications" id="email_notifications" {if $system['email_notifications']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Email User When")}
              </label>
              <div class="col-md-9">
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" name="email_post_likes" id="email_post_likes" {if $system['email_post_likes']}checked{/if}>
                  <label class="custom-control-label" for="email_post_likes">{__("Someone liked his post")}</label>
                </div>
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" name="email_post_comments" id="email_post_comments" {if $system['email_post_comments']}checked{/if}>
                  <label class="custom-control-label" for="email_post_comments">{__("Someone commented on his post")}</label>
                </div>
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" name="email_post_shares" id="email_post_shares" {if $system['email_post_shares']}checked{/if}>
                  <label class="custom-control-label" for="email_post_shares">{__("Someone shared his post")}</label>
                </div>
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" name="email_wall_posts" id="email_wall_posts" {if $system['email_wall_posts']}checked{/if}>
                  <label class="custom-control-label" for="email_wall_posts">{__("Someone posted on his timeline")}</label>
                </div>
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" name="email_mentions" id="email_mentions" {if $system['email_mentions']}checked{/if}>
                  <label class="custom-control-label" for="email_mentions">{__("Someone mentioned him")}</label>
                </div>
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" name="email_profile_visits" id="email_profile_visits" {if $system['email_profile_visits']}checked{/if}>
                  <label class="custom-control-label" for="email_profile_visits">{__("Someone visited his profile")}</label>
                </div>
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" name="email_friend_requests" id="email_friend_requests" {if $system['email_friend_requests']}checked{/if}>
                  <label class="custom-control-label" for="email_friend_requests">{__("Someone sent him or accepted his friend requset")}</label>
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
      </div>
      <!-- Email Notifications -->

      <!-- Push Notifications -->
      <div class="tab-pane" id="Push">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=push_notifications">
          <div class="card-body">

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="onesignal" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("OneSignal Push Notifications")}</div>
                <div class="form-text d-none d-sm-block">{__("Turn the OneSignal push notification On and Off")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="onesignal_notification_enabled">
                  <input type="checkbox" name="onesignal_notification_enabled" id="onesignal_notification_enabled" {if $system['onesignal_notification_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("OneSignal APP ID")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="onesignal_app_id" value="{$system['onesignal_app_id']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("OneSignal REST API Key")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="onesignal_api_key" value="{$system['onesignal_api_key']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
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
      </div>
      <!-- Push Notifications -->
    </div>

  {elseif $sub_view == "chat"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Chat")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Chat -->
    <form class="js_ajax-forms" data-url="admin/settings.php?edit=chat">
      <div class="card-body">
        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="chat" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Chat Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the chat system On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="chat_enabled">
              <input type="checkbox" name="chat_enabled" id="chat_enabled" {if $system['chat_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="voice_notes" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Voice Notes")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the voice notes in chat On and Off")}<br>
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="voice_notes_chat_enabled">
              <input type="checkbox" name="voice_notes_chat_enabled" id="voice_notes_chat_enabled" {if $system['voice_notes_chat_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="chat_status" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("User Status Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the Last Seen On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="chat_status_enabled">
              <input type="checkbox" name="chat_status_enabled" id="chat_status_enabled" {if $system['chat_status_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="chat_typing" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Typing Status Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the Typing Status On and Off")} ({__("Needs a good server to work fine")})</div>
          </div>
          <div class="text-right">
            <label class="switch" for="chat_typing_enabled">
              <input type="checkbox" name="chat_typing_enabled" id="chat_typing_enabled" {if $system['chat_typing_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="chat_seen" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Seen Status Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the Seen Status On and Off")} ({__("Needs a good server to work fine")})</div>
          </div>
          <div class="text-right">
            <label class="switch" for="chat_seen_enabled">
              <input type="checkbox" name="chat_seen_enabled" id="chat_seen_enabled" {if $system['chat_seen_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="delete" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Delete For Everyone")}</div>
            <div class="form-text d-none d-sm-block">{__("Permanently remove the conversation for all chat members when user delete it")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="chat_permanently_delete_enabled">
              <input type="checkbox" name="chat_permanently_delete_enabled" id="chat_permanently_delete_enabled" {if $system['chat_permanently_delete_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="call_audio" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Audio Call Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the audio call system On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="audio_call_enabled">
              <input type="checkbox" name="audio_call_enabled" id="audio_call_enabled" {if $system['audio_call_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Who Can Start Audio Call")}
          </label>
          <div class="col-md-9">
            <select class="form-control selectpicker" name="audio_call_permission">
              <option value="admins" {if $system['audio_call_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
              <option value="pro" {if $system['audio_call_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
              <option value="verified" {if $system['audio_call_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
              <option value="everyone" {if $system['audio_call_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
            </select>
          </div>
        </div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="call_video" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Video Call Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the video call system On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="video_call_enabled">
              <input type="checkbox" name="video_call_enabled" id="video_call_enabled" {if $system['video_call_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Who Can Start Video Call")}
          </label>
          <div class="col-md-9">
            <select class="form-control selectpicker" name="video_call_permission">
              <option value="admins" {if $system['video_call_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
              <option value="pro" {if $system['video_call_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
              <option value="verified" {if $system['video_call_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
              <option value="everyone" {if $system['video_call_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
            </select>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Twilio Account SID")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="twilio_sid" value="{$system['twilio_sid']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Twilio API SID")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="twilio_apisid" value="{$system['twilio_apisid']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Twilio API SECRET")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="twilio_apisecret" value="{$system['twilio_apisecret']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
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
    <!-- Chat -->

  {elseif $sub_view == "live"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Live Stream")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Live -->
    <form class="js_ajax-forms" data-url="admin/settings.php?edit=live">
      <div class="card-body">
        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="live" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Live Stream Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn the live stream system On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="live_enabled">
              <input type="checkbox" name="live_enabled" id="live_enabled" {if $system['live_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Who Can Go Live")}
          </label>
          <div class="col-md-9">
            <select class="form-control selectpicker" name="live_permission">
              <option value="admins" {if $system['live_permission'] == "admins"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-lock fa-lg fa-fw'></i></div><div class='text'><b>{__("Admins")}<span class='d-none d-md-inline'><br>{__("Only Admins and Moderators")}</span></div></div>">{__("Admins")}</option>
              <option value="pro" {if $system['live_permission'] == "pro"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-rocket fa-lg fa-fw'></i></div><div class='text'><b>{__("Pro Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators and Pro Users")}</span></div></div>">{__("Pro Users")}</option>
              <option value="verified" {if $system['live_permission'] == "verified"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-check-circle fa-lg fa-fw'></i></div><div class='text'><b>{__("Verified Users")}<span class='d-none d-md-inline'><br>{__("Only Admins, Moderators, Pro and Verified Users")}</span></div></div>">{__("Verified Users")}</option>
              <option value="everyone" {if $system['live_permission'] == "everyone"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-globe fa-lg fa-fw'></i></div><div class='text'><b>{__("Everyone")}<span class='d-none d-md-inline'><br>{__("Any user in the system can")}</span></div></div>">{__("Everyone")}</option>
            </select>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Agora App ID")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="agora_app_id" value="{$system['agora_app_id']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Agora App Certificate")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="agora_app_certificate" value="{$system['agora_app_certificate']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="folder" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Save Live Videos")}</div>
            <div class="form-text d-none d-sm-block">
              {__("Turn the save live stream videos On and Off")}<br>
            </div>
          </div>
          <div class="text-right">
            <label class="switch" for="save_live_enabled">
              <input type="checkbox" name="save_live_enabled" id="save_live_enabled" {if $system['save_live_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Agora Customer ID")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="agora_customer_id" value="{$system['agora_customer_id']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Agora Customer Secret")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="agora_customer_certificate" value="{$system['agora_customer_certificate']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {"S3"} {__("Bucket Name")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="agora_s3_bucket" value="{$system['agora_s3_bucket']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
            <span class="form-text">
              {__("Your Amazon S3 bucket name")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {"S3"} {__("Bucket Region")}
          </label>
          <div class="col-md-9">
            <select name="agora_s3_region" class="form-control">
              <option value="us-east-1" {if $system['agora_s3_region'] == "us-east-1"}selected{/if}>US East (N. Virginia) us-east-1</option>
              <option value="us-east-2" {if $system['agora_s3_region'] == "us-east-2"}selected{/if}>US East (Ohio) us-east-2</option>
              <option value="us-west-1" {if $system['agora_s3_region'] == "us-west-1"}selected{/if}>US West (N. California) us-west-1</option>
              <option value="us-west-2" {if $system['agora_s3_region'] == "us-west-2"}selected{/if}>US West (Oregon) us-west-2</option>
              <option value="eu-west-1" {if $system['agora_s3_region'] == "eu-west-1"}selected{/if}>EU (Ireland) eu-west-1</option>
              <option value="eu-west-2" {if $system['agora_s3_region'] == "eu-west-2"}selected{/if}>EU (London) eu-west-2</option>
              <option value="eu-west-3" {if $system['agora_s3_region'] == "eu-west-3"}selected{/if}>EU (Paris) eu-west-3</option>
              <option value="eu-central-1" {if $system['agora_s3_region'] == "eu-central-1"}selected{/if}>EU (Frankfurt) eu-central-1</option>
              <option value="ap-southeast-1" {if $system['agora_s3_region'] == "ap-southeast-1"}selected{/if}>Asia Pacific (Singapore) ap-southeast-1</option>
              <option value="ap-southeast-2" {if $system['agora_s3_region'] == "ap-southeast-2"}selected{/if}>Asia Pacific (Sydney) ap-southeast-2</option>
              <option value="ap-northeast-1" {if $system['agora_s3_region'] == "ap-northeast-1"}selected{/if}>Asia Pacific (Tokyo) ap-northeast-1</option>
              <option value="ap-northeast-2" {if $system['agora_s3_region'] == "ap-northeast-2"}selected{/if}>Asia Pacific (Seoul) ap-northeast-2</option>
              <option value="sa-east-1" {if $system['agora_s3_region'] == "sa-east-1"}selected{/if}>South America (São Paulo) sa-east-1</option>
              <option value="ca-central-1" {if $system['agora_s3_region'] == "ca-central-1"}selected{/if}>Canada (Central) ca-central-1</option>
              <option value="ap-south-1" {if $system['agora_s3_region'] == "ap-south-1"}selected{/if}>Asia Pacific (Mumbai)</option>
            </select>
            <span class="form-text">
              {__("Your Amazon S3 bucket region")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {"S3"} {__("Access Key ID")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="agora_s3_key" value="{$system['agora_s3_key']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
            <span class="form-text">
              {__("Your Amazon S3 Access Key ID")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {"S3"} {__("Access Key Secret")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="agora_s3_secret" value="{$system['agora_s3_secret']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
            <span class="form-text">
              {__("Your Amazon S3 Access Key Secret")}
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
        <button type="button" class="btn btn-danger js_admin-tester" data-handle="s3-agora">
          <i class="fa fa-bolt mr10"></i> {__("Test Connection")} ({__("S3")})
        </button>
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>
    <!-- Live -->

  {elseif $sub_view == "uploads"}

    <!-- card-header -->
    <div class="card-header with-icon with-nav">
      <!-- panel title -->
      <div class="mb20">
        <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Uploads")}
      </div>
      <!-- panel title -->

      <!-- panel nav -->
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link active" href="#General" data-toggle="tab">
            <i class="fa fa-upload fa-fw mr5"></i><strong class="pr5">{__("General")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#S3" data-toggle="tab">
            <i class="fab fa-amazon fa-fw mr5"></i><strong class="pr5">{__("Amazon S3")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#DigitalOcean" data-toggle="tab">
            <i class="fab fa-digital-ocean fa-fw mr5"></i><strong class="pr5">{__("DigitalOcean")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Wasabi" data-toggle="tab">
            {include file='__svg_icons.tpl' icon="wasabi" width="15px" height="15px"}<strong class="ml5 pr5">{__("Wasabi")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Google" data-toggle="tab">
            <i class="fab fa-google fa-fw mr5"></i><strong class="ml5 pr5">{__("Google Cloud")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#FTP" data-toggle="tab">
            <i class="fa fa-cloud-upload-alt fa-fw mr5"></i><strong class="pr5">{__("FTP")}</strong>
          </a>
        </li>
      </ul>
      <!-- panel nav -->
    </div>
    <!-- card-header -->

    <!-- tabs content -->
    <div class="tab-content">
      <!-- General -->
      <div class="tab-pane active" id="General">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=uploads">
          <div class="card-body">
            <div class="alert alert-warning">
              <div class="icon">
                <i class="fa fa-exclamation-triangle fa-2x"></i>
              </div>
              <div class="text">
                {__("Your server max upload size")} = {$max_upload_size}<br>
                {__("You can't upload files larger than")} {$max_upload_size} - {__("To upload larger files, contact your hosting provider")}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Uploads Directory")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="uploads_directory" value="{$system['uploads_directory']}">
                <span class="form-text">
                  {__("The path of uploads local directory")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Uploads Prefix")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="uploads_prefix" value="{$system['uploads_prefix']}">
                <span class="form-text">
                  {__("Add a prefix to the uploaded files (No spaces or special characters only like 'mysite' or 'my_site')")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Uploads CDN Endpoint")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="uploads_cdn_url" value="{$system['uploads_cdn_url']}">
                <span class="form-text">
                  {__("Your CDN URL like AWS CloudFront")}
                </span>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="photos" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Photo Upload")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable photo upload to share & upload photos to the site")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="photos_enabled">
                  <input type="checkbox" name="photos_enabled" id="photos_enabled" {if $system['photos_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                <div style="width: 40px; height: 40px;"></div>
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Photo Upload in Comments")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable photo upload in comments")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="comments_photos_enabled">
                  <input type="checkbox" name="comments_photos_enabled" id="comments_photos_enabled" {if $system['comments_photos_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                <div style="width: 40px; height: 40px;"></div>
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Photo Upload in Chat")} </div>
                <div class="form-text d-none d-sm-block">{__("Enable photo upload in chat")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="chat_photos_enabled">
                  <input type="checkbox" name="chat_photos_enabled" id="chat_photos_enabled" {if $system['chat_photos_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                <div style="width: 40px; height: 40px;"></div>
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Photo Upload in Blogs and Forums")} </div>
                <div class="form-text d-none d-sm-block">{__("Enable photo upload in articles and forums threads")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="tinymce_photos_enabled">
                  <input type="checkbox" name="tinymce_photos_enabled" id="tinymce_photos_enabled" {if $system['tinymce_photos_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Max Photo Size")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="max_photo_size" value="{$system['max_photo_size']}">
                <span class="form-text">
                  {__("The Maximum size of uploaded photo in posts")} {__("in kilobytes (1M = 1024KB)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Photo Quality")}
              </label>
              <div class="col-md-9">
                <select class="form-control selectpicker" name="uploads_quality">
                  <option value="high" {if $system['uploads_quality'] == "high"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-battery-full fa-lg fa-fw'></i></div><div class='text'><b>{__('High Quality')}<span class='d-none d-md-inline'><br>{__('High quality photos with low compression')}</span></div></div>">{__("High Quality")}</option>
                  <option value="medium" {if $system['uploads_quality'] == "medium"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-battery-half fa-lg fa-fw'></i></div><div class='text'><b>{__('Medium Quality')}<span class='d-none d-md-inline'><br>{__('Medium quality photos with medium compression')}</span></div></div>">{__("Medium Quality")}</option>
                  <option value="low" {if $system['uploads_quality'] == "low"}selected{/if} data-content="<div class='option'><div class='icon'><i class='fa fa-battery-empty fa-lg fa-fw'></i></div><div class='text'><b>{__('Low Quality')}<span class='d-none d-md-inline'><br>{__('Low quality photos with high compression')}</span></div></div>">{__("Low Quality")}</option>
                </select>
              </div>
            </div>

            <div class="divider dashed"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="resolution" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Cover Photo Resolution Limit")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable cover photo limit (Minimum width 1108px & Minimum height 360px)")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="limit_cover_photo">
                  <input type="checkbox" name="limit_cover_photo" id="limit_cover_photo" {if $system['limit_cover_photo']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Max Cover Photo Size")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="max_cover_size" value="{$system['max_cover_size']}">
                <span class="form-text">
                  {__("The Maximum size of cover photo")} {__("in kilobytes (1 M = 1024 KB)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Max Profile Photo Size")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="max_avatar_size" value="{$system['max_avatar_size']}">
                <span class="form-text">
                  {__("The Maximum size of profile photo")} {__("in kilobytes (1 M = 1024 KB)")}
                </span>
              </div>
            </div>

            <div class="divider dashed"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="watermark" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Watermark Images")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Enable it to add watermark icon to all uploaded photos (except: profile pictures and cover images)")}
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="watermark_enabled">
                  <input type="checkbox" name="watermark_enabled" id="watermark_enabled" {if $system['watermark_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Watermark Icon")}
              </label>
              <div class="col-md-9">
                {if $system['watermark_icon'] == ''}
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
                    <input type="hidden" class="js_x-image-input" name="watermark_icon" value="">
                  </div>
                {else}
                  <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$system['watermark_icon']}')">
                    <button type="button" class="close js_x-image-remover" title='{__("Remove")}'>
                      <span>×</span>
                    </button>
                    <div class="x-image-loader">
                      <div class="progress x-progress">
                        <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                      </div>
                    </div>
                    <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
                    <input type="hidden" class="js_x-image-input" name="watermark_icon" value="{$system['watermark_icon']}">
                  </div>
                {/if}
                <span class="form-text">
                  {__("Upload your watermark icon (PNG is recommended)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Watermark Position")}
              </label>
              <div class="col-md-9">
                <select class="form-control" name="watermark_position">
                  <option {if $system['watermark_position'] == "top left"}selected{/if} value="top left">{__("Top Left")}</option>
                  <option {if $system['watermark_position'] == "top right"}selected{/if} value="top right">{__("Top Right")}</option>
                  <option {if $system['watermark_position'] == "top"}selected{/if} value="top">{__("Top")}</option>
                  <option {if $system['watermark_position'] == "bottom left"}selected{/if} value="bottom left">{__("Bottom Left")}</option>
                  <option {if $system['watermark_position'] == "bottom right"}selected{/if} value="bottom right">{__("Bottom Right")}</option>
                  <option {if $system['watermark_position'] == "bottom"}selected{/if} value="bottom">{__("Bottom")}</option>
                  <option {if $system['watermark_position'] == "left"}selected{/if} value="left">{__("Left")}</option>
                  <option {if $system['watermark_position'] == "right"}selected{/if} value="right">{__("Right")}</option>
                </select>
                <span class="form-text">
                  {__("Select the position (the anchor point) of your watermark icon")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Watermark Opacity")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="watermark_opacity" value="{$system['watermark_opacity']}">
                <span class="form-text">
                  {__("The opacity level of the watermark icon (value between 0 - 1)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Watermark X Offset")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="watermark_xoffset" value="{$system['watermark_xoffset']}">
                <span class="form-text">
                  {__("Horizontal offset in pixels")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Watermark Y Offset")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="watermark_yoffset" value="{$system['watermark_yoffset']}">
                <span class="form-text">
                  {__("Vertical offset in pixels")}
                </span>
              </div>
            </div>

            <div class="divider dashed"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="adult" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Adult Images Detection")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Enable it to detect the adult images and system will blur or delete them")}
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="adult_images_enabled">
                  <input type="checkbox" name="adult_images_enabled" id="adult_images_enabled" {if $system['adult_images_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Adult Images Action")}
              </label>
              <div class="col-md-9">
                <div class="custom-control custom-radio custom-control-inline">
                  <input type="radio" name="adult_images_action" id="action_blue" value="blur" class="custom-control-input" {if $system['adult_images_action'] == "blur"}checked{/if}>
                  <label class="custom-control-label" for="action_blue">{__("Blur")}</label>
                </div>
                <div class="custom-control custom-radio custom-control-inline">
                  <input type="radio" name="adult_images_action" id="action_delete" value="delete" class="custom-control-input" {if $system['adult_images_action'] == "delete"}checked{/if}>
                  <label class="custom-control-label" for="action_delete">{__("Delete")}</label>
                </div>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Google Vision API Key")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="adult_images_api_key" value="{$system['adult_images_api_key']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("Your Cloud Vision API Key")}
                </span>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="videos" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Video Upload")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable video upload to share & upload videos to the site")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="videos_enabled">
                  <input type="checkbox" name="videos_enabled" id="videos_enabled" {if $system['videos_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Max video size")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="max_video_size" value="{$system['max_video_size']}">
                <span class="form-text">
                  {__("The Maximum size of uploaded video in posts")} {__("in kilobytes (1M = 1024KB)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Video extensions")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="video_extensions" value="{$system['video_extensions']}">
                <span class="form-text">
                  {__("Allowed video extensions (separated with comma ',)")}
                </span>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="audios" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("Audio Upload")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable audio upload to share & upload sounds to the site")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="audio_enabled">
                  <input type="checkbox" name="audio_enabled" id="audio_enabled" {if $system['audio_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Max audio size")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="max_audio_size" value="{$system['max_audio_size']}">
                <span class="form-text">
                  {__("The Maximum size of uploaded audio in posts")} {__("in kilobytes (1M = 1024KB)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Audio extensions")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="audio_extensions" value="{$system['audio_extensions']}">
                <span class="form-text">
                  {__("Allowed audio extensions (separated with comma ',)")}
                </span>
              </div>
            </div>

            <div class="divider"></div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="files" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6 mb5">{__("File Upload")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable file upload to share & upload files to the site")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="file_enabled">
                  <input type="checkbox" name="file_enabled" id="file_enabled" {if $system['file_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Max file size")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="max_file_size" value="{$system['max_file_size']}">
                <span class="form-text">
                  {__("The Maximum size of uploaded file in posts")} {__("in kilobytes (1M = 1024KB)")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("File extensions")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="file_extensions" value="{$system['file_extensions']}">
                <span class="form-text">
                  {__("Allowed file extensions (separated with comma ',)")}
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
            <button type="button" class="btn btn-danger js_admin-tester" data-handle="google_vision">
              <i class="fa fa-bolt mr10"></i> {__("Test Connection (Vision API)")}
            </button>
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- General -->

      <!-- S3 -->
      <div class="tab-pane" id="S3">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=s3">
          <div class="card-body">
            <div class="alert alert-primary">
              <div class="icon">
                <i class="fab fa-amazon fa-2x"></i>
              </div>
              <div class="text">
                <strong>{__("Amazon S3 Storage")}</strong><br>
                {__("Before enabling Amazon S3, make sure you upload the whole 'uploads' folder to your bucket")}.<br>
                {__("Before disabling Amazon S3, make sure you download the whole 'uploads' folder to your server")}.
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="aws_s3" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Amazon S3 Storage")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Enable Amazon S3 storage")} ({__("Note: Enable this will disable all other options")})
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="s3_enabled">
                  <input type="checkbox" name="s3_enabled" id="s3_enabled" {if $system['s3_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bucket Name")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="s3_bucket" value="{$system['s3_bucket']}">
                <span class="form-text">
                  {__("Your Amazon S3 bucket name")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bucket Region")}
              </label>
              <div class="col-md-9">
                <select name="s3_region" class="form-control">
                  <option value="us-east-2" {if $system['s3_region'] == "us-east-2"}selected{/if}>US East (Ohio) us-east-2</option>
                  <option value="us-east-1" {if $system['s3_region'] == "us-east-1"}selected{/if}>US East (N. Virginia) us-east-1</option>
                  <option value="us-west-1" {if $system['s3_region'] == "us-west-1"}selected{/if}>US West (N. California) us-west-1</option>
                  <option value="us-west-2" {if $system['s3_region'] == "us-west-2"}selected{/if}>US West (Oregon) us-west-2</option>
                  <option value="ap-east-1" {if $system['s3_region'] == "ap-east-1"}selected{/if}>Asia Pacific (Hong Kong) ap-east-1</option>
                  <option value="ap-south-1" {if $system['s3_region'] == "ap-south-1"}selected{/if}>Asia Pacific (Mumbai)</option>
                  <option value="ap-northeast-3" {if $system['s3_region'] == "ap-northeast-3"}selected{/if}>Asia Pacific (Osaka-Local) ap-northeast-3</option>
                  <option value="ap-northeast-2" {if $system['s3_region'] == "ap-northeast-2"}selected{/if}>Asia Pacific (Seoul) ap-northeast-2</option>
                  <option value="ap-southeast-1" {if $system['s3_region'] == "ap-southeast-1"}selected{/if}>Asia Pacific (Singapore) ap-southeast-1</option>
                  <option value="ap-southeast-2" {if $system['s3_region'] == "ap-southeast-2"}selected{/if}>Asia Pacific (Sydney) ap-southeast-2</option>
                  <option value="ap-northeast-1" {if $system['s3_region'] == "ap-northeast-1"}selected{/if}>Asia Pacific (Tokyo) ap-northeast-1</option>
                  <option value="ca-central-1" {if $system['s3_region'] == "ca-central-1"}selected{/if}>Canada (Central) ca-central-1</option>
                  <option value="eu-central-1" {if $system['s3_region'] == "eu-central-1"}selected{/if}>EU (Frankfurt) eu-central-1</option>
                  <option value="eu-west-1" {if $system['s3_region'] == "eu-west-1"}selected{/if}>EU (Ireland) eu-west-1</option>
                  <option value="eu-west-2" {if $system['s3_region'] == "eu-west-2"}selected{/if}>EU (London) eu-west-2</option>
                  <option value="eu-west-3" {if $system['s3_region'] == "eu-west-3"}selected{/if}>EU (Paris) eu-west-3</option>
                  <option value="eu-north-1" {if $system['s3_region'] == "eu-north-1"}selected{/if}>Europe (Stockholm) eu-north-1</option>
                  <option value="me-south-1" {if $system['s3_region'] == "me-south-1"}selected{/if}>Middle East (Bahrain) me-south-1</option>
                  <option value="sa-east-1" {if $system['s3_region'] == "sa-east-1"}selected{/if}>South America (São Paulo) sa-east-1</option>
                </select>
                <span class="form-text">
                  {__("Your Amazon S3 bucket region")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Access Key ID")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="s3_key" value="{$system['s3_key']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("Your Amazon S3 Access Key ID")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Access Key Secret")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="s3_secret" value="{$system['s3_secret']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("Your Amazon S3 Access Key Secret")}
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
            <button type="button" class="btn btn-danger js_admin-tester" data-handle="s3">
              <i class="fa fa-bolt mr10"></i> {__("Test Connection")}
            </button>
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- S3 -->

      <!-- DigitalOcean -->
      <div class="tab-pane" id="DigitalOcean">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=digitalocean">
          <div class="card-body">
            <div class="alert alert-primary">
              <div class="icon">
                <i class="fab fa-digital-ocean fa-2x"></i>
              </div>
              <div class="text">
                <strong>{__("DigitalOcean")}</strong><br>
                {__("Before enabling DigitalOcean Space, make sure you upload the whole 'uploads' folder to your space")}.<br>
                {__("Before disabling DigitalOcean Space, make sure you download the whole 'uploads' folder to your server")}.
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="digitalocean" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("DigitalOcean Space")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Enable DigitalOcean storage")} ({__("Note: Enable this will disable all other options")})
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="digitalocean_enabled">
                  <input type="checkbox" name="digitalocean_enabled" id="digitalocean_enabled" {if $system['digitalocean_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Space Name")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="digitalocean_space_name" value="{$system['digitalocean_space_name']}">
                <span class="form-text">
                  {__("Your DigitalOcean space name")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Space Region")}
              </label>
              <div class="col-md-9">
                <select name="digitalocean_space_region" class="form-control">
                  <option value="sfo2" {if $system['digitalocean_space_region'] == "sfo2"}selected{/if}>San Francisco 2</option>
                  <option value="sfo3" {if $system['digitalocean_space_region'] == "sfo3"}selected{/if}>San Francisco 3</option>
                  <option value="nyc3" {if $system['digitalocean_space_region'] == "nyc3"}selected{/if}>New York</option>
                  <option value="ams3" {if $system['digitalocean_space_region'] == "ams3"}selected{/if}>Amsterdam</option>
                  <option value="sgp1" {if $system['digitalocean_space_region'] == "sgp1"}selected{/if}>Singapore</option>
                  <option value="fra1" {if $system['digitalocean_space_region'] == "fra1"}selected{/if}>Frankfurt</option>
                </select>
                <span class="form-text">
                  {__("Your DigitalOcean space region")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Access Key ID")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="digitalocean_key" value="{$system['digitalocean_key']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("Your DigitalOcean Access Key ID")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Access Key Secret")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="digitalocean_secret" value="{$system['digitalocean_secret']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("Your DigitalOcean Access Key Secret")}
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
            <button type="button" class="btn btn-danger js_admin-tester" data-handle="digitalocean">
              <i class="fa fa-bolt mr10"></i> {__("Test Connection")}
            </button>
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- DigitalOcean -->

      <!-- Wasabi -->
      <div class="tab-pane" id="Wasabi">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=wasabi">
          <div class="card-body">
            <div class="alert alert-primary">
              <div class="icon">
                {include file='__svg_icons.tpl' icon="wasabi" width="25px" height="25px"}
              </div>
              <div class="text">
                <strong>{__("Wasabi")}</strong><br>
                {__("Before enabling Wasabi, make sure you upload the whole 'uploads' folder to your bucket")}.<br>
                {__("Before disabling Wasabi, make sure you download the whole 'uploads' folder to your server")}.
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="wasabi" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Wasabi")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Enable Wasabi storage")} ({__("Note: Enable this will disable all other options")})
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="wasabi_enabled">
                  <input type="checkbox" name="wasabi_enabled" id="wasabi_enabled" {if $system['wasabi_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bucket Name")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="wasabi_bucket" value="{$system['wasabi_bucket']}">
                <span class="form-text">
                  {__("Your Wasabi bucket name")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bucket Region")}
              </label>
              <div class="col-md-9">
                <select name="wasabi_region" class="form-control">
                  <option value="us-west-1" {if $system['wasabi_region'] == "us-west-1"}selected{/if}>us-west-1</option>
                  <option value="ap-northeast-1" {if $system['wasabi_region'] == "ap-northeast-1"}selected{/if}>ap-northeast-1</option>
                  <option value="ap-northeast-2" {if $system['wasabi_region'] == "ap-northeast-2"}selected{/if}>ap-northeast-2</option>
                  <option value="eu-central-1" {if $system['wasabi_region'] == "eu-central-1"}selected{/if}>eu-central-1</option>
                  <option value="eu-west-1" {if $system['wasabi_region'] == "eu-west-1"}selected{/if}>eu-west-1</option>
                  <option value="us-central-1" {if $system['wasabi_region'] == "us-central-1"}selected{/if}>us-central-1</option>
                  <option value="us-east-1" {if $system['wasabi_region'] == "us-east-1"}selected{/if}>us-east-1</option>
                  <option value="us-east-2" {if $system['wasabi_region'] == "us-east-2"}selected{/if}>us-east-2</option>
                </select>
                <span class="form-text">
                  {__("Your Wasabi bucket region")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Access Key ID")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="wasabi_key" value="{$system['wasabi_key']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("Your Wasabi Access Key ID")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Access Key Secret")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="wasabi_secret" value="{$system['wasabi_secret']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("Your Wasabi Access Key Secret")}
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
            <button type="button" class="btn btn-danger js_admin-tester" data-handle="wasabi">
              <i class="fa fa-bolt mr10"></i> {__("Test Connection")}
            </button>
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- Wasabi -->

      <!-- Google -->
      <div class="tab-pane" id="Google">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=google_cloud">
          <div class="card-body">
            <div class="alert alert-primary">
              <div class="icon">
                <i class="fab fa-google fa-2x"></i>
              </div>
              <div class="text">
                <strong>{__("Google Cloud")}</strong><br>
                {__("Before enabling Google Cloud, make sure you upload the whole 'uploads' folder to your bucket")}.<br>
                {__("Before disabling Google Cloud, make sure you download the whole 'uploads' folder to your server")}.
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="google_cloud" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Google Cloud")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Enable Google Cloud storage")} ({__("Note: Enable this will disable all other options")})
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="google_cloud_enabled">
                  <input type="checkbox" name="google_cloud_enabled" id="google_cloud_enabled" {if $system['google_cloud_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bucket Name")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="google_cloud_bucket" value="{$system['google_cloud_bucket']}">
                <span class="form-text">
                  {__("Your Google Cloud bucket name")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Google Cloud File")}
              </label>
              <div class="col-md-9">
                <textarea name="google_cloud_file" id="google_cloud_file">{$system['google_cloud_file']}</textarea>
                <span class="form-text">
                  {__("Your service account keys JSON")}
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
            <button type="button" class="btn btn-danger js_admin-tester" data-handle="google_cloud">
              <i class="fa fa-bolt mr10"></i> {__("Test Connection")}
            </button>
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- Wasabi -->

      <!-- FTP -->
      <div class="tab-pane" id="FTP">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=ftp">
          <div class="card-body">
            <div class="alert alert-primary">
              <div class="icon">
                <i class="fa fa-cloud-upload-alt fa-2x"></i>
              </div>
              <div class="text">
                <strong>{__("FTP Storage")}</strong><br>
                {__("Before enabling FTP Storage, make sure you upload the whole 'uploads' folder to your space")}.<br>
                {__("Before disabling FTP Storage, make sure you download the whole 'uploads' folder to your server")}.
              </div>
            </div>

            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="ftp" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("FTP Storage")}</div>
                <div class="form-text d-none d-sm-block">
                  {__("Enable FTP Storage upload")} ({__("Note: Enable this will disable all other options")})
                </div>
              </div>
              <div class="text-right">
                <label class="switch" for="ftp_enabled">
                  <input type="checkbox" name="ftp_enabled" id="ftp_enabled" {if $system['ftp_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Hostname")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="ftp_hostname" value="{$system['ftp_hostname']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Port")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="ftp_port" value="{$system['ftp_port']}" placeholder="21">
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Username")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="ftp_username" value="{$system['ftp_username']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Password")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="ftp_password" value="{$system['ftp_password']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("FTP Path")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="ftp_path" value="{$system['ftp_path']}" placeholder="./">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("The path to your uploads folder (Examples: './' or 'public_html/uploads')")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("FTP Endpoint")}
              </label>
              <div class="col-md-9">
                {if !$user->_data['user_demo']}
                  <input type="text" class="form-control" name="ftp_endpoint" value="{$system['ftp_endpoint']}">
                {else}
                  <input type="password" class="form-control" value="*********">
                {/if}
                <span class="form-text">
                  {__("The URL to your uploads folder (Examples: 'https://domain.com/uploads' or 'https://64.233.191.255/uploads')")}
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
            <button type="button" class="btn btn-danger js_admin-tester" data-handle="ftp">
              <i class="fa fa-bolt mr10"></i> {__("Test Connection")}
            </button>
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- FTP -->
    </div>
    <!-- tabs content -->

  {elseif $sub_view == "security"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Security")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Security -->
    <form class="js_ajax-forms" data-url="admin/settings.php?edit=security">
      <div class="card-body">
        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="hacker" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Unusual Login Detection")}</div>
            <div class="form-text d-none d-sm-block">{__("Enable unusual login detection, System will not allow user to login with same session from different device or location")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="unusual_login_enabled">
              <input type="checkbox" name="unusual_login_enabled" id="unusual_login_enabled" {if $system['unusual_login_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="firewall" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Brute Force Detection")}</div>
            <div class="form-text d-none d-sm-block">{__("Enable brute force attack detection, System will block the user account if hacker try to login with invalid password too many times to guess the correct account password")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="brute_force_detection_enabled">
              <input type="checkbox" name="brute_force_detection_enabled" id="brute_force_detection_enabled" {if $system['brute_force_detection_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Bad Login Limit")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="brute_force_bad_login_limit" value="{$system['brute_force_bad_login_limit']}">
            <span class="form-text">
              {__("Number of bad login attempts till account get blocked")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Lockout Time")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="brute_force_lockout_time" value="{$system['brute_force_lockout_time']}">
            <span class="form-text">
              {__("Number of minutes the account will still locked out")}
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="fingerprint" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Two-Factor Authentication")}</div>
            <div class="form-text d-none d-sm-block">{__("Enable two-factor authentication to log in with a code from your email/phone as well as a password")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="two_factor_enabled">
              <input type="checkbox" name="two_factor_enabled" id="two_factor_enabled" {if $system['two_factor_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-sm-3 form-control-label">
            {__("Two-Factor Authentication Via")}
          </label>
          <div class="col-md-9">
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" name="two_factor_type" id="two_factor_email" value="email" class="custom-control-input" {if $system['two_factor_type'] == "email"}checked{/if}>
              <label class="custom-control-label" for="two_factor_email">{__("Email")}</label>
            </div>
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" name="two_factor_type" id="two_factor_sms" value="sms" class="custom-control-input" {if $system['two_factor_type'] == "sms"}checked{/if}>
              <label class="custom-control-label" for="two_factor_sms">{__("SMS")}</label>
            </div>
            <div class="custom-control custom-radio custom-control-inline">
              <input type="radio" name="two_factor_type" id="two_factor_google" value="google" class="custom-control-input" {if $system['two_factor_type'] == "google"}checked{/if}>
              <label class="custom-control-label" for="two_factor_google">{__("Google Authenticator")}</label>
            </div>
            <span class="form-text">
              {__("Select Email, SMS or Google Authenticator to send log in code to user")}<br>
              {__("Make sure you have configured")} <a href="{$system['system_url']}/{$control_panel['url']}/settings/sms">{__("SMS Settings")}</a>
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="censored" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("Censored Words Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Enable/Disable Words to be censored")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="censored_words_enabled">
              <input type="checkbox" name="censored_words_enabled" id="censored_words_enabled" {if $system['censored_words_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Censored Words")}
          </label>
          <div class="col-md-9">
            <textarea class="form-control" name="censored_words" rows="3">{$system['censored_words']}</textarea>
            <span class="form-text">
              {__("Words to be censored, separated by a comma (,)")}
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="html" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("HTML Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Enable/Disable HTML code in Rich Text Editor (blogs and forums)")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="html_richtext_enabled">
              <input type="checkbox" name="html_richtext_enabled" id="html_richtext_enabled" {if $system['html_richtext_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-table-row">
          <div class="avatar">
            {include file='__svg_icons.tpl' icon="google_recaptcha" width="40px" height="40px"}
          </div>
          <div>
            <div class="form-control-label h6">{__("reCAPTCHA Enabled")}</div>
            <div class="form-text d-none d-sm-block">{__("Turn reCAPTCHA On and Off")}</div>
          </div>
          <div class="text-right">
            <label class="switch" for="reCAPTCHA_enabled">
              <input type="checkbox" name="reCAPTCHA_enabled" id="reCAPTCHA_enabled" {if $system['reCAPTCHA_enabled']}checked{/if}>
              <span class="slider round"></span>
            </label>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("reCAPTCHA Site Key")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="reCAPTCHA_site_key" value="{$system['reCAPTCHA_site_key']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("reCAPTCHA Secret Key")}
          </label>
          <div class="col-md-9">
            {if !$user->_data['user_demo']}
              <input type="text" class="form-control" name="reCAPTCHA_secret_key" value="{$system['reCAPTCHA_secret_key']}">
            {else}
              <input type="password" class="form-control" value="*********">
            {/if}
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
    <!-- Security -->

  {elseif $sub_view == "payments"}

    <!-- card-header -->
    <div class="card-header with-icon with-nav">
      <!-- panel title -->
      <div class="mb20">
        <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Payments")}
      </div>
      <!-- panel title -->

      <!-- panel nav -->
      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link active" href="#Payments" data-toggle="tab">
            <i class="fa fa-credit-card fa-fw mr5"></i><strong class="pr5">{__("Online Payments")}</strong>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#Bank" data-toggle="tab">
            <i class="fa fa-university fa-fw mr5"></i><strong class="pr5">{__("Bank Transfers")}</strong>
          </a>
        </li>
      </ul>
      <!-- panel nav -->
    </div>
    <!-- card-header -->

    <!-- tabs content -->
    <div class="tab-content">
      <!-- Payments -->
      <div class="tab-pane active" id="Payments">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=payments">
          <div class="card-body">

            <!-- PayPal -->
            <div>
              <div class="form-table-row">
                <div class="avatar">
                  {include file='__svg_icons.tpl' icon="paypal" width="40px" height="40px"}
                </div>
                <div>
                  <div class="form-control-label h6">{__("Paypal Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via Paypal")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="paypal_enabled">
                    <input type="checkbox" name="paypal_enabled" id="paypal_enabled" {if $system['paypal_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Paypal Mode")}
                </label>
                <div class="col-md-9">
                  <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" name="paypal_mode" id="paypal_live" value="live" class="custom-control-input" {if $system['paypal_mode'] == "live"}checked{/if}>
                    <label class="custom-control-label" for="paypal_live">{__("Live")}</label>
                  </div>
                  <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" name="paypal_mode" id="paypal_sandbox" value="sandbox" class="custom-control-input" {if $system['paypal_mode'] == "sandbox"}checked{/if}>
                    <label class="custom-control-label" for="paypal_sandbox">{__("Sandbox")}</label>
                  </div>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("PayPal Client ID")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="paypal_id" value="{$system['paypal_id']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("PayPal Secret Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="paypal_secret" value="{$system['paypal_secret']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>
            </div>
            <!-- PayPal -->

            <div class="divider"></div>

            <!-- Stripe -->
            <div>
              <div class="form-table-row">
                <div class="avatar">
                  {include file='__svg_icons.tpl' icon="stripe" width="40px" height="40px"}
                </div>
                <div>
                  <div class="form-control-label h6">{__("Stripe Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via Credit Card")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="creditcard_enabled">
                    <input type="checkbox" name="creditcard_enabled" id="creditcard_enabled" {if $system['creditcard_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-table-row">
                <div class="avatar">
                  {include file='__svg_icons.tpl' icon="alipay" width="40px" height="40px"}
                </div>
                <div>
                  <div class="form-control-label h6">{__("Alipay Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via Alipay")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="alipay_enabled">
                    <input type="checkbox" name="alipay_enabled" id="alipay_enabled" {if $system['alipay_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Stripe Mode")}
                </label>
                <div class="col-md-9">
                  <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" name="stripe_mode" id="stripe_live" value="live" class="custom-control-input" {if $system['stripe_mode'] == "live"}checked{/if}>
                    <label class="custom-control-label" for="stripe_live">{__("Live")}</label>
                  </div>
                  <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" name="stripe_mode" id="stripe_test" value="test" class="custom-control-input" {if $system['stripe_mode'] == "test"}checked{/if}>
                    <label class="custom-control-label" for="stripe_test">{__("Test")}</label>
                  </div>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Test Secret Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="stripe_test_secret" value="{$system['stripe_test_secret']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                  <span class="form-text">
                    {__("Stripe secret key that starts with sk_")}
                  </span>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Test Publishable Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="stripe_test_publishable" value="{$system['stripe_test_publishable']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                  <span class="form-text">
                    {__("Stripe publishable key that starts with pk_")}
                  </span>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Live Secret Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="stripe_live_secret" value="{$system['stripe_live_secret']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                  <span class="form-text">
                    {__("Stripe secret key that starts with sk_")}
                  </span>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Live Publishable Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="stripe_live_publishable" value="{$system['stripe_live_publishable']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                  <span class="form-text">
                    {__("Stripe publishable key that starts with pk_")}
                  </span>
                </div>
              </div>
            </div>
            <!-- Stripe -->

            <div class="divider"></div>

            <!-- Paystack -->
            <div>
              <div class="form-table-row">
                <div class="avatar">
                  {include file='__svg_icons.tpl' icon="paystack" width="40px" height="40px"}
                </div>
                <div>
                  <div class="form-control-label h6">{__("Paystack Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via Paystack")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="paystack_enabled">
                    <input type="checkbox" name="paystack_enabled" id="paystack_enabled" {if $system['paystack_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Secret Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="paystack_secret" value="{$system['paystack_secret']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                  <span class="form-text">
                    {__("Paystack secret key that starts with sk_")}
                  </span>
                </div>
              </div>
            </div>
            <!-- Paystack -->

            <div class="divider"></div>

            <!-- CoinPayments -->
            <div>
              <div class="form-table-row">
                <div class="avatar">
                  {include file='__svg_icons.tpl' icon="bitcoin" width="40px" height="40px"}
                </div>
                <div>
                  <div class="form-control-label h6">{__("CoinPayments Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via CoinPayments")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="coinpayments_enabled">
                    <input type="checkbox" name="coinpayments_enabled" id="coinpayments_enabled" {if $system['coinpayments_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Merchant ID")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="coinpayments_merchant_id" value="{$system['coinpayments_merchant_id']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("IPN Secret")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="coinpayments_ipn_secret" value="{$system['coinpayments_ipn_secret']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>
            </div>
            <!-- CoinPayments -->

            <div class="divider"></div>

            <!-- 2Checkout -->
            <div>
              <div class="form-table-row">
                <div class="avatar">
                  {include file='__svg_icons.tpl' icon="2co" width="40px" height="40px"}
                </div>
                <div>
                  <div class="form-control-label h6">{__("2Checkout Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via 2Checkout")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="2checkout_enabled">
                    <input type="checkbox" name="2checkout_enabled" id="2checkout_enabled" {if $system['2checkout_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("2Checkout Mode")}
                </label>
                <div class="col-md-9">
                  <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" name="2checkout_mode" id="2checkout_live" value="live" class="custom-control-input" {if $system['2checkout_mode'] == "live"}checked{/if}>
                    <label class="custom-control-label" for="2checkout_live">{__("Live")}</label>
                  </div>
                  <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" name="2checkout_mode" id="2checkout_sandbox" value="sandbox" class="custom-control-input" {if $system['2checkout_mode'] == "sandbox"}checked{/if}>
                    <label class="custom-control-label" for="2checkout_sandbox">{__("Demo")}</label>
                  </div>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Merchant Code")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="2checkout_merchant_code" value="{$system['2checkout_merchant_code']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("API Publishable Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="2checkout_publishable_key" value="{$system['2checkout_publishable_key']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("API Private Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="2checkout_private_key" value="{$system['2checkout_private_key']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>
            </div>
            <!-- 2Checkout -->

            <div class="divider"></div>

            <!-- Razorpay -->
            <div>
              <div class="form-table-row">
                <div class="avatar">
                  {include file='__svg_icons.tpl' icon="razorpay" width="40px" height="40px"}
                </div>
                <div>
                  <div class="form-control-label h6">{__("Razorpay Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via Razorpay")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="razorpay_enabled">
                    <input type="checkbox" name="razorpay_enabled" id="razorpay_enabled" {if $system['razorpay_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Key ID")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="razorpay_key_id" value="{$system['razorpay_key_id']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Key Secret")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="razorpay_key_secret" value="{$system['razorpay_key_secret']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>
            </div>
            <!-- Razorpay -->

            <div class="divider"></div>

            <!-- Cashfree -->
            <div>
              <div class="form-table-row">
                <div class="avatar">
                  <img width="40px" height="40px" src="{$system['system_url']}/content/themes/{$system['theme']}/images/cashfree.png">
                </div>
                <div>
                  <div class="form-control-label h6">{__("Cashfree Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via Cashfree")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="cashfree_enabled">
                    <input type="checkbox" name="cashfree_enabled" id="cashfree_enabled" {if $system['cashfree_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Cashfree Mode")}
                </label>
                <div class="col-md-9">
                  <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" name="cashfree_mode" id="Cashfree_live" value="live" class="custom-control-input" {if $system['cashfree_mode'] == "live"}checked{/if}>
                    <label class="custom-control-label" for="Cashfree_live">{__("Live")}</label>
                  </div>
                  <div class="custom-control custom-radio custom-control-inline">
                    <input type="radio" name="cashfree_mode" id="Cashfree_sandbox" value="sandbox" class="custom-control-input" {if $system['cashfree_mode'] == "sandbox"}checked{/if}>
                    <label class="custom-control-label" for="Cashfree_sandbox">{__("Sandbox")}</label>
                  </div>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Client ID")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="cashfree_client_id" value="{$system['cashfree_client_id']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("Client Secret")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="cashfree_client_secret" value="{$system['cashfree_client_secret']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>
            </div>
            <!-- Cashfree -->

            <div class="divider"></div>

            <!-- Coinbase -->
            <div>
              <div class="form-table-row">
                <div class="avatar">
                  {include file='__svg_icons.tpl' icon="coinbase" width="40px" height="40px"}
                </div>
                <div>
                  <div class="form-control-label h6">{__("Coinbase Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via Coinbase")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="coinbase_enabled">
                    <input type="checkbox" name="coinbase_enabled" id="coinbase_enabled" {if $system['coinbase_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("API Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="coinbase_api_key" value="{$system['coinbase_api_key']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>
            </div>
            <!-- Coinbase -->

            <div class="divider"></div>

            <!-- SecurionPay -->
            <div>
              <div class="form-table-row">
                <div class="avatar">
                  {include file='__svg_icons.tpl' icon="securionpay" width="40px" height="40px"}
                </div>
                <div>
                  <div class="form-control-label h6">{__("SecurionPay Enabled")}</div>
                  <div class="form-text d-none d-sm-block">{__("Enable payments via SecurionPay")}</div>
                </div>
                <div class="text-right">
                  <label class="switch" for="securionpay_enabled">
                    <input type="checkbox" name="securionpay_enabled" id="securionpay_enabled" {if $system['securionpay_enabled']}checked{/if}>
                    <span class="slider round"></span>
                  </label>
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("API Key")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="securionpay_api_key" value="{$system['securionpay_api_key']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>

              <div class="form-group form-row">
                <label class="col-md-3 form-control-label">
                  {__("API Secret")}
                </label>
                <div class="col-md-9">
                  {if !$user->_data['user_demo']}
                    <input type="text" class="form-control" name="securionpay_api_secret" value="{$system['securionpay_api_secret']}">
                  {else}
                    <input type="password" class="form-control" value="*********">
                  {/if}
                </div>
              </div>
            </div>
            <!-- SecurionPay -->

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
      </div>
      <!-- Payments -->

      <!-- Bank -->
      <div class="tab-pane" id="Bank">
        <form class="js_ajax-forms" data-url="admin/settings.php?edit=bank">
          <div class="card-body">
            <div class="form-table-row">
              <div class="avatar">
                {include file='__svg_icons.tpl' icon="bank" width="40px" height="40px"}
              </div>
              <div>
                <div class="form-control-label h6">{__("Bank Transfers Enabled")}</div>
                <div class="form-text d-none d-sm-block">{__("Enable payments via Bank Transfers")}</div>
              </div>
              <div class="text-right">
                <label class="switch" for="bank_transfers_enabled">
                  <input type="checkbox" name="bank_transfers_enabled" id="bank_transfers_enabled" {if $system['bank_transfers_enabled']}checked{/if}>
                  <span class="slider round"></span>
                </label>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bank Name")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="bank_name" value="{$system['bank_name']}">
                <span class="form-text">
                  {__("Your Bank Name")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bank Account Number")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="bank_account_number" value="{$system['bank_account_number']}">
                <span class="form-text">
                  {__("Your Bank Account Number")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bank Account Name")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="bank_account_name" value="{$system['bank_account_name']}">
                <span class="form-text">
                  {__("Your Bank Account Name")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bank Account Routing Code")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="bank_account_routing" value="{$system['bank_account_routing']}">
                <span class="form-text">
                  {__("Your Bank Account Routing Code or SWIFT Code")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Bank Account Country")}
              </label>
              <div class="col-md-9">
                <input type="text" class="form-control" name="bank_account_country" value="{$system['bank_account_country']}">
                <span class="form-text">
                  {__("Your Bank Account Country")}
                </span>
              </div>
            </div>

            <div class="form-group form-row">
              <label class="col-md-3 form-control-label">
                {__("Transfer Note")}
              </label>
              <div class="col-md-9">
                <textarea class="form-control" name="bank_transfer_note" rows="5">{$system['bank_transfer_note']}</textarea>
                <span class="form-text">
                  {__("This note will be displayed to the user while upload his bank transfer receipt")}
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
            <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
          </div>
        </form>
      </div>
      <!-- Bank -->
    </div>

  {elseif $sub_view == "limits"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Limits")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Limits -->
    <form class="js_ajax-forms" data-url="admin/settings.php?edit=limits">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Data Heartbeat")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="data_heartbeat" value="{$system['data_heartbeat']}">
            <span class="form-text">
              {__("The update interval to check for new data (in seconds)")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Chat Heartbeat")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="chat_heartbeat" value="{$system['chat_heartbeat']}">
            <span class="form-text">
              {__("The update interval to check for new messages (in seconds)")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Offline After")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="offline_time" value="{$system['offline_time']}">
            <span class="form-text">
              {__("The amount of time to be considered online since the last user's activity (in seconds)")}<br>
              {__("The maximim value is one day = 86400 seconds")}
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Newsfeed Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="newsfeed_results" value="{$system['newsfeed_results']}">
            <span class="form-text">
              {__("The number of posts in the newsfeed")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Pages Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="pages_results" value="{$system['pages_results']}">
            <span class="form-text">
              {__("The number of results in the pages module")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Groups Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="groups_results" value="{$system['groups_results']}">
            <span class="form-text">
              {__("The number of results in the groups module")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Events Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="events_results" value="{$system['events_results']}">
            <span class="form-text">
              {__("The number of results in the events module")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Marketplace Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="marketplace_results" value="{$system['marketplace_results']}">
            <span class="form-text">
              {__("The number of results in the marketplace module")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Offers Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="offers_results" value="{$system['offers_results']}">
            <span class="form-text">
              {__("The number of results in the offers module")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Jobs Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="jobs_results" value="{$system['jobs_results']}">
            <span class="form-text">
              {__("The number of results in the jobs module")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Games Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="games_results" value="{$system['games_results']}">
            <span class="form-text">
              {__("The number of results in the games module")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Search Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="search_results" value="{$system['search_results']}">
            <span class="form-text">
              {__("The number of results in the search module")}
            </span>
          </div>
        </div>

        <div class="divider"></div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Minimum Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="min_results" value="{$system['min_results']}">
            <span class="form-text">
              {__("The Min number of results per request")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Maximum Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="max_results" value="{$system['max_results']}">
            <span class="form-text">
              {__("The Max number of results per request")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Minimum Even Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="min_results_even" value="{$system['min_results_even']}">
            <span class="form-text">
              {__("The Min even number of results per request")}
            </span>
          </div>
        </div>

        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Maximum Even Results")}
          </label>
          <div class="col-md-9">
            <input type="text" class="form-control" name="max_results_even" value="{$system['max_results_even']}">
            <span class="form-text">
              {__("The Max even number of results per request")}
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
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>
    <!-- Limits -->

  {elseif $sub_view == "analytics"}

    <!-- card-header -->
    <div class="card-header with-icon">
      <!-- panel title -->
      <i class="fa fa-cog mr10"></i>{__("Settings")} &rsaquo; {__("Analytics")}
      <!-- panel title -->
    </div>
    <!-- card-header -->

    <!-- Analytics -->
    <form class="js_ajax-forms" data-url="admin/settings.php?edit=analytics">
      <div class="card-body">
        <div class="form-group form-row">
          <label class="col-md-3 form-control-label">
            {__("Tracking Code")}
          </label>
          <div class="col-md-9">
            <textarea class="form-control" name="message" rows="3">{$system['analytics_code']}</textarea>
            <span class="form-text">
              {__("The analytics tracking code (Ex: Google Analytics)")}
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
        <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
      </div>
    </form>
    <!-- Analytics -->

  {/if}

</div>