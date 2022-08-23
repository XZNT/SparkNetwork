<div class="card">
  <div class="card-header with-icon">
    <i class="fa fa-paint-brush mr10"></i>{__("Design")}
  </div>
  <form class="js_ajax-forms" data-url="admin/design.php">
    <div class="card-body">
      <div class="form-table-row">
        <div class="avatar">
          {include file='__svg_icons.tpl' icon="night_mode" width="40px" height="40px"}
        </div>
        <div>
          <div class="form-control-label h6">{__("Night Mode is Default")}</div>
          <div class="form-text d-none d-sm-block">
            {__("Make the night mode is the default mode of your website")}
          </div>
        </div>
        <div class="text-right">
          <label class="switch" for="system_theme_night_on">
            <input type="checkbox" name="system_theme_night_on" id="system_theme_night_on" {if $system['system_theme_night_on']}checked{/if}>
            <span class="slider round"></span>
          </label>
        </div>
      </div>

      <div class="form-table-row">
        <div class="avatar">
          {include file='__svg_icons.tpl' icon="user_night_mode" width="40px" height="40px"}
        </div>
        <div>
          <div class="form-control-label h6">{__("Users Can Change Mode")}</div>
          <div class="form-text d-none d-sm-block">
            {__("Allow users to select between day and night mode")}
          </div>
        </div>
        <div class="text-right">
          <label class="switch" for="system_theme_mode_select">
            <input type="checkbox" name="system_theme_mode_select" id="system_theme_mode_select" {if $system['system_theme_mode_select']}checked{/if}>
            <span class="slider round"></span>
          </label>
        </div>
      </div>

      <div class="divider"></div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Website Logo")}
        </label>
        <div class="col-md-9">
          {if $system['system_logo'] == ''}
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
              <input type="hidden" class="js_x-image-input" name="system_logo" value="">
            </div>
          {else}
            <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$system['system_logo']}')">
              <button type="button" class="close js_x-image-remover" title='{__("Remove")}'>
                <span>×</span>
              </button>
              <div class="x-image-loader">
                <div class="progress x-progress">
                  <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
              <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
              <input type="hidden" class="js_x-image-input" name="system_logo" value="{$system['system_logo']}">
            </div>
          {/if}
        </div>
      </div>

      <div class="divider"></div>

      <div class="form-table-row">
        <div class="avatar">
          {include file='__svg_icons.tpl' icon="wallpaper" width="40px" height="40px"}
        </div>
        <div>
          <div class="form-control-label h6">{__("Default Home Wallpaper")}</div>
          <div class="form-text d-none d-sm-block">
            {__("Use the default")} ({__("Disable it to use your custom uploaded image")})
          </div>
        </div>
        <div class="text-right">
          <label class="switch" for="system_wallpaper_default">
            <input type="checkbox" name="system_wallpaper_default" id="system_wallpaper_default" {if $system['system_wallpaper_default']}checked{/if}>
            <span class="slider round"></span>
          </label>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Custom Home Wallpaper")}
        </label>
        <div class="col-md-9">
          {if $system['system_wallpaper'] == ''}
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
              <input type="hidden" class="js_x-image-input" name="system_wallpaper" value="">
            </div>
          {else}
            <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$system['system_wallpaper']}')">
              <button type="button" class="close js_x-image-remover" title='{__("Remove")}'>
                <span>×</span>
              </button>
              <div class="x-image-loader">
                <div class="progress x-progress">
                  <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
              <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
              <input type="hidden" class="js_x-image-input" name="system_wallpaper" value="{$system['system_wallpaper']}">
            </div>
          {/if}
        </div>
      </div>

      <div class="divider"></div>

      <div class="form-table-row">
        <div class="avatar">
          {include file='__svg_icons.tpl' icon="star" width="40px" height="40px"}
        </div>
        <div>
          <div class="form-control-label h6">{__("Default Favicon")}</div>
          <div class="form-text d-none d-sm-block">
            {__("Use the default")} (<a target="_blank" href="{$system['system_url']}/content/themes/{$system['theme']}/images/favicon.png">{__("preview")}</a>) ({__("Disable it to use your custom uploaded image")})
          </div>
        </div>
        <div class="text-right">
          <label class="switch" for="system_favicon_default">
            <input type="checkbox" name="system_favicon_default" id="system_favicon_default" {if $system['system_favicon_default']}checked{/if}>
            <span class="slider round"></span>
          </label>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Custom Favicon")}
        </label>
        <div class="col-md-9">
          {if $system['system_favicon'] == ''}
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
              <input type="hidden" class="js_x-image-input" name="system_favicon" value="">
            </div>
          {else}
            <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$system['system_favicon']}')">
              <button type="button" class="close js_x-image-remover" title='{__("Remove")}'>
                <span>×</span>
              </button>
              <div class="x-image-loader">
                <div class="progress x-progress">
                  <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
              <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
              <input type="hidden" class="js_x-image-input" name="system_favicon" value="{$system['system_favicon']}">
            </div>
          {/if}
        </div>
      </div>

      <div class="divider"></div>

      <div class="form-table-row">
        <div class="avatar">
          {include file='__svg_icons.tpl' icon="social_share" width="40px" height="40px"}
        </div>
        <div>
          <div class="form-control-label h6">{__("Default OG-Image")}</div>
          <div class="form-text d-none d-sm-block">
            {__("Use the default")} (<a target="_blank" href="{$system['system_url']}/content/themes/{$system['theme']}/images/og-image.jpg">{__("preview")}</a>) ({__("Disable it to use your custom uploaded image")})
          </div>
        </div>
        <div class="text-right">
          <label class="switch" for="system_ogimage_default">
            <input type="checkbox" name="system_ogimage_default" id="system_ogimage_default" {if $system['system_ogimage_default']}checked{/if}>
            <span class="slider round"></span>
          </label>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Custom OG-Image")}
        </label>
        <div class="col-md-9">
          {if $system['system_ogimage'] == ''}
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
              <input type="hidden" class="js_x-image-input" name="system_ogimage" value="">
            </div>
          {else}
            <div class="x-image" style="background-image: url('{$system['system_uploads']}/{$system['system_ogimage']}')">
              <button type="button" class="close js_x-image-remover" title='{__("Remove")}'>
                <span>×</span>
              </button>
              <div class="x-image-loader">
                <div class="progress x-progress">
                  <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
              </div>
              <i class="fa fa-camera fa-lg js_x-uploader" data-handle="x-image"></i>
              <input type="hidden" class="js_x-image-input" name="system_ogimage" value="{$system['system_ogimage']}">
            </div>
          {/if}
          <span class="form-text">
            {__("The perfect size for your og-image should be (wdith: 590px & height: 300px)")}
          </span>
        </div>
      </div>

      <div class="divider"></div>

      <div class="form-table-row">
        <div class="avatar">
          {include file='__svg_icons.tpl' icon="playstore" width="40px" height="40px"}
        </div>
        <div>
          <div class="form-control-label h6">{__("Google Play Store Badge")}</div>
          <div class="form-text d-none d-sm-block">{__("Show Google Play Store badge on the landing page")}</div>
        </div>
        <div class="text-right">
          <label class="switch" for="play_store_badge_enabled">
            <input type="checkbox" name="play_store_badge_enabled" id="play_store_badge_enabled" {if $system['play_store_badge_enabled']}checked{/if}>
            <span class="slider round"></span>
          </label>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Google Play Store Link")}
        </label>
        <div class="col-md-9">
          <input type="text" class="form-control" name="play_store_link" value="{$system['play_store_link']}">
          <span class="form-text">
            {__("The app link on Google Play Store")}
          </span>
        </div>
      </div>

      <div class="divider"></div>

      <div class="form-table-row">
        <div class="avatar">
          {include file='__svg_icons.tpl' icon="appgallery" width="40px" height="40px"}
        </div>
        <div>
          <div class="form-control-label h6">{__("Huawei AppGallery Badge")}</div>
          <div class="form-text d-none d-sm-block">{__("Show Huawei AppGallery badge on the landing page")}</div>
        </div>
        <div class="text-right">
          <label class="switch" for="appgallery_badge_enabled">
            <input type="checkbox" name="appgallery_badge_enabled" id="appgallery_badge_enabled" {if $system['appgallery_badge_enabled']}checked{/if}>
            <span class="slider round"></span>
          </label>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Huawei AppGallery Link")}
        </label>
        <div class="col-md-9">
          <input type="text" class="form-control" name="appgallery_store_link" value="{$system['appgallery_store_link']}">
          <span class="form-text">
            {__("The app link on Huawei AppGallery")}
          </span>
        </div>
      </div>

      <div class="divider"></div>

      <div class="form-table-row">
        <div class="avatar">
          {include file='__svg_icons.tpl' icon="appstore" width="40px" height="40px"}
        </div>
        <div>
          <div class="form-control-label h6">{__("Apple App Store Badge")}</div>
          <div class="form-text d-none d-sm-block">{__("Show Apple App Store badge on the landing page")}</div>
        </div>
        <div class="text-right">
          <label class="switch" for="app_store_badge_enabled">
            <input type="checkbox" name="app_store_badge_enabled" id="app_store_badge_enabled" {if $system['app_store_badge_enabled']}checked{/if}>
            <span class="slider round"></span>
          </label>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Apple App Store Link")}
        </label>
        <div class="col-md-9">
          <input type="text" class="form-control" name="app_store_link" value="{$system['app_store_link']}">
          <span class="form-text">
            {__("The app link on Apple App Store")}
          </span>
        </div>
      </div>

      <div class="divider"></div>

      <div class="form-table-row">
        <div class="avatar">
          {include file='__svg_icons.tpl' icon="css" width="40px" height="40px"}
        </div>
        <div>
          <div class="form-control-label h6">{__("Enable Customization")}</div>
          <div class="form-text d-none d-sm-block">{__("Turn the customization On and Off")}</div>
        </div>
        <div class="text-right">
          <label class="switch" for="css_customized">
            <input type="checkbox" name="css_customized" id="css_customized" {if $system['css_customized']}checked{/if}>
            <span class="slider round"></span>
          </label>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Background Color")}
        </label>
        <div class="col-md-9">
          <div class="input-group js_colorpicker">
            <input type="text" class="form-control" name="css_background" value="{$system['css_background']}" />
            <span class="input-group-append">
              <span class="input-group-text colorpicker-input-addon"><i></i></span>
            </span>
          </div>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Link Color")}
        </label>
        <div class="col-md-9">
          <div class="input-group js_colorpicker">
            <input type="text" class="form-control" name="css_link_color" value="{$system['css_link_color']}" />
            <span class="input-group-append">
              <span class="input-group-text colorpicker-input-addon"><i></i></span>
            </span>
          </div>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Header Color")}
        </label>
        <div class="col-md-9">
          <div class="input-group js_colorpicker">
            <input type="text" class="form-control" name="css_header" value="{$system['css_header']}" />
            <span class="input-group-append">
              <span class="input-group-text colorpicker-input-addon"><i></i></span>
            </span>
          </div>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Header Search Background")}
        </label>
        <div class="col-md-9">
          <div class="input-group js_colorpicker">
            <input type="text" class="form-control" name="css_header_search" value="{$system['css_header_search']}" />
            <span class="input-group-append">
              <span class="input-group-text colorpicker-input-addon"><i></i></span>
            </span>
          </div>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Header Search Font")}
        </label>
        <div class="col-md-9">
          <div class="input-group js_colorpicker">
            <input type="text" class="form-control" name="css_header_search_color" value="{$system['css_header_search_color']}" />
            <span class="input-group-append">
              <span class="input-group-text colorpicker-input-addon"><i></i></span>
            </span>
          </div>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Button Primary")}
        </label>
        <div class="col-md-9">
          <div class="input-group js_colorpicker">
            <input type="text" class="form-control" name="css_btn_primary" value="{$system['css_btn_primary']}" />
            <span class="input-group-append">
              <span class="input-group-text colorpicker-input-addon"><i></i></span>
            </span>
          </div>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Custom CSS")}
        </label>
        <div class="col-md-9">
          <textarea class="form-control" rows="10" name="css_custome_css" id="custom-css">{$system['css_custome_css']}</textarea>
          <span class="form-text">
            {__("Header Custom CSS")}
          </span>
        </div>
      </div>

      <div class="divider"></div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Header Custom JavaScript")}
        </label>
        <div class="col-md-9">
          <textarea name="custome_js_header" id="custome_js_header">{$system['custome_js_header']}</textarea>
          <span class="form-text">
            {__("The code will be added in head tag")}
          </span>
        </div>
      </div>

      <div class="form-group form-row">
        <label class="col-md-3 form-control-label">
          {__("Footer Custom JavaScript")}
        </label>
        <div class="col-md-9">
          <textarea name="custome_js_footer" id="custome_js_footer">{$system['custome_js_footer']}</textarea>
          <span class="form-text">
            {__("The code will be added at the end of body tag")}
          </span>
        </div>
      </div>

      <!-- error -->
      <div class="alert alert-danger mb0 x-hidden"></div>
      <!-- error -->
    </div>
    <div class="card-footer text-right">
      <button type="submit" class="btn btn-primary">{__("Save Changes")}</button>
    </div>
  </form>

</div>