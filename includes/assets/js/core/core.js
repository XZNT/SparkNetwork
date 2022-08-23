
// initialize API URLs
var api = [];
/* core */
api['core/theme'] = ajax_path + "core/theme.php";
/* data */
api['data/load'] = ajax_path + "data/load.php";
api['data/search'] = ajax_path + "data/search.php";
/* posts */
api['posts/lightbox'] = ajax_path + "posts/lightbox.php";
/* payments */
api['payments/paypal'] = ajax_path + "payments/paypal.php";
api['payments/paystack'] = ajax_path + "payments/paystack.php";
api['payments/stripe'] = ajax_path + "payments/stripe.php";
api['payments/coinpayments'] = ajax_path + "payments/coinpayments.php";
api['payments/2checkout'] = ajax_path + "payments/2checkout.php";
api['payments/razorpay'] = ajax_path + "payments/razorpay.php";
api['payments/cashfree'] = ajax_path + "payments/cashfree.php";
api['payments/coinbase'] = ajax_path + "payments/coinbase.php";
api['payments/securionpay'] = ajax_path + "payments/securionpay.php";
api['payments/wallet'] = ajax_path + "payments/wallet.php";
api['payments/trial'] = ajax_path + "payments/trial.php";
/* ads */
api['ads/click'] = ajax_path + "ads/click.php";


// stop audio
Audio.prototype.stop = function () {
  this.pause();
  this.currentTime = 0;
};


// guid
function guid() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);
  }
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
}


// htmlEntities
function htmlEntities(str) {
  return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}


// is empty
function is_empty(value) {
  if (value.match(/\S/) == null) {
    return true;
  } else {
    return false;
  }
}


// is empty
function is_iPad() {
  return navigator.userAgent.match(/iPad/i) != null;;
}


// get parameter by name
function get_parameter_by_name(name) {
  var url = window.location.href;
  name = name.replace(/[\[\]]/g, "\\$&");
  var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
    results = regex.exec(url);
  if (!results) return null;
  if (!results[2]) return '';
  return decodeURIComponent(results[2].replace(/\+/g, " "));
}


// initialize the plugins
function initialize() {
  // run bootstrap tooltip
  $('body').tooltip({
    selector: '[data-toggle="tooltip"], [data-tooltip=tooltip]'
  });
  // run Sngine scroll
  $('.js_scroller').each(function () {
    var _this = $(this);
    var ini_height = _this.attr('data-slimScroll-height') || '280px';
    var ini_start = _this.attr('data-slimScroll-start') || 'top';
    /* return if the scroll already running  */
    if (_this.parent().hasClass('custom-scrollbar')) {
      return;
    }
    /* run if not */
    _this.parent().addClass('custom-scrollbar');
    _this.css({ "overflow-y": "auto", "height": ini_height });
    if (ini_start == "bottom") {
      _this.scrollTop(_this.height());
    }
  });
  // run Sngine load-more
  /* load more data by scroll */
  $('.js_see-more-infinite').bind('inview', function (event, visible) {
    if ((desktop_infinite_scroll && $(window).width() >= 970) || (mobile_infinite_scroll && $(window).width() < 970)) {
      load_more($(this));
    }
  });
  // run Sngine audio files
  $("audio.js_audio").on("play", function () {
    $("audio").not(this).each(function (index, audio) {
      audio.pause();
    });
  });
  // run videojs plugin
  $("video.js_videojs").each(function () {
    if ($(this).parents('div.video-js').length == 0) {
      var _id = $(this).attr('id');
      videojs($(this)[0], {}, function () {
        this.on("play", function () {
          /* pause other video */
          $(".js_videojs").each(function () {
            if (_id !== $(this).attr('id')) {
              this.player.pause();
            }
          });
        });
      });
      // run auto-play videos
      if (auto_play_videos) {
        $(this).fracs(function (fracs, prev_fracs) {
          var video = $(this)[0];
          if (fracs.visible >= 1) {
            if (video.paused) {
              video.play();
            }
          } else {
            if (!video.paused) {
              video.pause();
            }
          }
        });
      }
    }
  });

  // run readmore plugin
  $('.js_readmore').each(function () {
    var _this = $(this);
    var height = _this.attr('data-height') || 110;
    /* return if the plugin already running  */
    if (_this.attr('data-readmore') !== undefined) {
      return;
    }
    /* run if not */
    _this.readmore({
      collapsedHeight: height,
      moreLink: '<a href="#">' + __['Read more'] + '</a>',
      lessLink: '<a href="#">' + __['Read less'] + '</a>',
      afterToggle: function (trigger, element, expanded) {
        if (expanded) {
          _this.css("height", "auto");
        }
      }
    });
  });
  // run autosize (expand textarea) plugin
  autosize($('.js_autosize'));
  // run moment plugin
  $(".js_moment").each(function () {
    var _this = $(this);
    var time_utc = _this.data('time');
    var locale = $('html').attr('lang') || 'en-us';
    var offset = moment().utcOffset();
    var time = moment(time_utc).add({ minutes: offset }).locale(locale);
    _this.text(time.fromNow()).attr('title', time.format("dddd, MMMM D, YYYY h:m a"));
  });
}


// modal
function modal() {
  if (arguments[0] == "#modal-login" || arguments[0] == "#chat-calling" || arguments[0] == "#chat-ringing") {
    /* disable the backdrop (don't close modal when click outside) */
    if ($('#modal').data('bs.modal')) {
      $('#modal').data('bs.modal').options = { backdrop: 'static', keyboard: false };
    } else {
      $('#modal').modal({ backdrop: 'static', keyboard: false });
    }
  }
  /* check if the modal not visible, show it */
  if (!$('#modal').is(":visible")) $('#modal').modal('show');
  /* prepare modal size */
  $('.modal-dialog').removeClass('modal-sm');
  $('.modal-dialog').removeClass('modal-lg');
  $('.modal-dialog').removeClass('modal-xlg');
  switch (arguments[2]) {
    case 'small':
      $('.modal-dialog').addClass('modal-sm');
      break;
    case 'large':
      $('.modal-dialog').addClass('modal-lg');
      break;
    case 'extra-large':
      $('.modal-dialog').addClass('modal-xl');
      break;
  }
  /* update the modal-content with the rendered template */
  $('.modal-content:last').html(render_template(arguments[0], arguments[1]));
  /* initialize modal if the function defined (user logged in) */
  if (typeof initialize_modal === "function") {
    initialize_modal();
  }
}


// confirm
function confirm(title, message, callback, password_check = false) {
  modal("#modal-confirm", { 'title': title, 'message': message, 'password_check': password_check });
  $("#modal-confirm-ok").click(function () {
    button_status($(this), "loading");
    if (callback) callback();
  });
}


// render template
function render_template(selector, options) {
  var template = $(selector).html();
  Mustache.parse(template);
  var rendered_template = Mustache.render(template, options);
  return rendered_template;
}


// load more
function load_more(element) {
  if (element.hasClass('done') || element.hasClass('loading')) return;
  var _this = element;
  var loading = _this.find('.loader');
  var text = _this.find('span');
  var remove = _this.data('remove') || false;
  if (_this.data('target-stream') !== undefined) {
    var stream = _this.parent().find('ul' + _this.data('target-stream'));
  } else {
    var stream = _this.parent().find('ul:first');
  }
  /* prepare data object */
  var data = {};
  data['get'] = _this.data('get');
  if (_this.data('filter') !== undefined) {
    data['filter'] = _this.data('filter');
  }
  if (_this.data('type') !== undefined) {
    data['type'] = _this.data('type');
  }
  if (_this.data('uid') !== undefined) {
    data['uid'] = _this.data('uid');
  }
  if (_this.data('id') !== undefined) {
    data['id'] = _this.data('id');
  }
  data['offset'] = _this.data('offset') || 1; /* we start from iteration 1 because 0 already loaded */
  /* show loader & hide text */
  _this.addClass('loading');
  text.hide();
  loading.removeClass('x-hidden');
  /* get & load data */
  $.post(api['data/load'], data, function (response) {
    _this.removeClass('loading');
    text.show();
    loading.addClass('x-hidden');
    /* check the response */
    if (response.callback) {
      eval(response.callback);
    } else {
      if (response.data) {
        data['offset']++;
        if (response.append) {
          stream.append(response.data);
        } else {
          stream.prepend(response.data);
        }
        setTimeout(photo_grid(), 200);
        /* color chat box */
        if (data['get'] == "messages") {
          chat_widget = _this.parents('.chat-widget, .panel-messages');
          color_chat_box(chat_widget, chat_widget.data('color'));
        }
      } else {
        if (remove) {
          _this.remove();
        } else {
          _this.addClass('done');
          text.text(__['There is no more data to show']);
        }
      }
    }
    _this.data('offset', data['offset']);
  }, 'json')
    .fail(function () {
      _this.removeClass('loading');
      text.show();
      loading.addClass('x-hidden');
      modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
    });
}


// photo grid
function photo_grid() {
  /* main photo */
  $('.pg_2o3_in').each(function () {
    if ($(this).parents('.pg_3x').length > 0) {
      var width = height = $(this).parents('.pg_3x').width() * 0.667;
    }
    if ($(this).parents('.pg_4x').length > 0) {
      var width = height = $(this).parents('.pg_4x').width() * 0.749;
    }
    $(this).width(width);
    $(this).height(height);
  });
  /* side photos */
  $('.pg_1o3_in').each(function () {
    if ($(this).parents('.pg_3x').length > 0) {
      var width = $(this).parents('.pg_3x').width() * 0.332;
      var height = ($(this).parent('.pg_1o3').prev().height() - 1) / 2;
    }
    if ($(this).parents('.pg_4x').length > 0) {
      var width = $(this).parents('.pg_4x').width() * 0.25;
      var height = ($(this).parent('.pg_1o3').prev().height() - 2) / 3;
    }
    $(this).width(width);
    $(this).height(height);
  });
}


// button status
function button_status(element, handle) {
  if (handle == "loading") {
    /* loading */
    element.data('text', element.html());
    element.prop('disabled', true);
    element.html('<span class="spinner-grow spinner-grow-sm mr10"></span>' + __['Loading']);
  } else {
    /* reset */
    element.prop('disabled', false);
    element.html(element.data('text'));
  }
}


$(function () {

  // init plugins
  initialize();
  $(document).ajaxComplete(function () {
    initialize();
  });


  // init hash
  var _t = $('body').attr('data-hash-tok');
  var _p = $('body').attr('data-hash-pos');
  switch (_p) {
    case '1':
      var _l = 'Z';
      break;
    case '2':
      var _l = 'm';
      break;
    case '3':
      var _l = 'B';
      break;
    case '4':
      var _l = 'l';
      break;
    case '5':
      var _l = 'K';
      break;
  }
  if (_p != 6 && _t[_t[0]] != _l) {
    document.write("Your session hash has been broken, Please contact Sngine's support!");
  }


  // init offcanvas-sidebar
  var _scroll_pos = 0;
  $('[data-toggle=offcanvas]').click(function () {
    $('.offcanvas').toggleClass('active');
    if ($('.offcanvas').hasClass('active')) {
      _scroll_pos = $(window).scrollTop();
      $('.offcanvas').css('minHeight', $('.offcanvas-sidebar').height());
    } else {
      $('.offcanvas').css('minHeight', 'unset');
      setTimeout(() => {
        $(window).scrollTop(_scroll_pos);
      }, 100);
    }
  });


  // run photo grid
  photo_grid();
  $(window).on("resize", function () {
    setTimeout(photo_grid(), 200);
  });


  // run bootstrap modal
  $('body').on('click', '[data-toggle="modal"]', function (e) {
    e.preventDefault();
    if ($(e.target).hasClass('link') && $(e.target).hasClass('disabled')) {
      return false;
    }
    var url = $(this).data('url');
    var options = $(this).data('options');
    var size = $(this).data('size') || "default";
    if (url.indexOf('#') == 0) {
      /* open already loaded modal with #id */
      modal(url, options, size);
    } else {
      /* init loading modal */
      modal('#modal-loading');
      /* get & load modal from url */
      $.getJSON(ajax_path + url, function (response) {
        /* check the response */
        if (!response) return;
        /* check if there is a callback */
        if (response.callback) {
          eval(response.callback);
        }
      })
        .fail(function () {
          modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
        });
    }
  });


  // run lightbox
  /* open the lightbox */
  $('body').on('click', '.js_lightbox', function (e) {
    e.preventDefault();
    /* initialize vars */
    var id = $(this).data('id');
    var image = $(this).data('image');
    var context = $(this).data('context');
    /* load lightbox */
    var lightbox = $(render_template("#lightbox", { 'image': image }));
    var next = lightbox.find('.lightbox-next');
    var prev = lightbox.find('.lightbox-prev');
    $('body').addClass('lightbox-open').append(lightbox.fadeIn('fast'));
    /* get photo */
    $.post(api['posts/lightbox'], { 'id': id, 'context': context }, function (response) {
      /* check the response */
      if (response.callback) {
        $('body').removeClass('lightbox-open');
        $('.lightbox').remove();
        eval(response.callback);
      } else {
        /* update next */
        if (response.next != null) {
          next.show();
          next.data('id', response.next.photo_id);
          next.data('source', response.next.source);
          next.data('context', context);
        } else {
          next.hide();
          next.data('id', '');
          next.data('source', '');
          next.data('context', '');
        }
        /* update prev */
        if (response.prev != null) {
          prev.show();
          prev.data('id', response.prev.photo_id);
          prev.data('source', response.prev.source);
          prev.data('context', context);
        } else {
          prev.hide();
          prev.data('id', '');
          prev.data('source', '');
          prev.data('context', '');
        }
        lightbox.find('.lightbox-post').replaceWith(response.lightbox);
      }
    }, 'json');
  });
  $('body').on('click', '.js_lightbox-slider', function (e) {
    /* initialize vars */
    var id = $(this).data('id');
    var image = $(this).data('source');
    var context = $(this).data('context');
    /* load lightbox */
    var lightbox = $(this).parents('.lightbox');
    var next = lightbox.find('.lightbox-next');
    var prev = lightbox.find('.lightbox-prev');
    /* loading */
    next.hide();
    prev.hide();
    lightbox.find('.lightbox-post').html('<div class="loader mtb10"></div>');
    lightbox.find('.lightbox-preview img').attr('src', uploads_path + '/' + image);
    /* get photo */
    $.post(api['posts/lightbox'], { 'id': id, 'context': context }, function (response) {
      /* check the response */
      if (response.callback) {
        $('body').removeClass('lightbox-open');
        lightbox.remove();
        eval(response.callback);
      } else {
        /* update next */
        if (response.next != null) {
          next.show();
          next.data('id', response.next.photo_id);
          next.data('source', response.next.source);
          next.data('context', context);
        } else {
          next.hide();
          next.data('id', '');
          next.data('source', '');
          next.data('context', '');
        }
        /* update prev */
        if (response.prev != null) {
          prev.show();
          prev.data('id', response.prev.photo_id);
          prev.data('source', response.prev.source);
          prev.data('context', context);
        } else {
          prev.hide();
          prev.data('id', '');
          prev.data('source', '');
          prev.data('context', '');
        }
        lightbox.find('.lightbox-post').replaceWith(response.lightbox);
      }
    }, 'json');
  });
  /* open the lightbox with no data */
  $('body').on('click', '.js_lightbox-nodata', function (e) {
    e.preventDefault();
    /* initialize vars */
    var image = $(this).data('image');
    /* load lightbox */
    var lightbox = $(render_template("#lightbox-nodata", { 'image': image }));
    $('body').addClass('lightbox-open').append(lightbox.fadeIn('fast'));
  });
  /* close the lightbox (when click outside the lightbox content) */
  $('body').on('click', '.lightbox', function (e) {
    if ($(e.target).is(".lightbox")) {
      if (typeof end_live_audience !== "undefined") {
        end_live_audience();
      }
      $('body').removeClass('lightbox-open');
      $('.lightbox').remove();
    }
  });
  /* close the lightbox (when click the close button) */
  $('body').on('click', '.js_lightbox-close', function () {
    if (typeof end_live_audience !== "undefined") {
      end_live_audience();
    }
    $('body').removeClass('lightbox-open');
    $('.lightbox').remove();
  });
  /* close the lightbox (when press Esc button) */
  $('body').on('keydown', function (e) {
    if (e.keyCode === 27 && $('.lightbox').length > 0) {
      if (typeof end_live_audience !== "undefined") {
        end_live_audience();
      }
      $('body').removeClass('lightbox-open');
      $('.lightbox').remove();
    }
  });


  // bootsrap dropdown keep open
  $('body').on('click', '.js_dropdown-keepopen', function (e) {
    e.stopPropagation();
  });


  // run bootstrap btn-group
  $('body').on('click', '.btn-group .dropdown-item', function (e) {
    e.preventDefault();
    var parent = $(this).parents('.btn-group');
    /* change the value */
    parent.find('input[type="hidden"]').val($(this).data('value'));
    /* copy text to btn-group-text */
    parent.find('.btn-group-text').text($(this).text());
    /* copy icon to btn-group-icon */
    parent.find('.btn-group-icon').attr("class", $(this).find('i.fa').attr("class")).addClass('btn-group-icon');
    /* copy title to tooltip */
    parent.attr('data-original-title', $(this).data('title'));
    parent.attr('data-value', $(this).data('value'));
    parent.data('value', $(this).data('value'));
    parent.tooltip();
  });


  // run toggle-panel
  $('.js_toggle-panel').click(function (event) {
    event.preventDefault;
    var parent = $(this).parents('.js_panel');
    parent.hide();
    parent.siblings().fadeIn();
    return false;
  });


  // run ajax-forms
  function _submitAJAXform(element) {
    var url = element.data('url');
    var submit = element.find('button[type="submit"]');
    var error = element.find('.alert.alert-danger');
    var success = element.find('.alert.alert-success');
    /* show any collapsed section if any */
    if (element.find('.js_hidden-section').length > 0 && !element.find('.js_hidden-section').is(':visible')) {
      element.find('.js_hidden-section').slideDown();
      return false;
    }
    /* button loading */
    button_status(submit, "loading");
    /* tinyMCE triggerSave if any */
    if (typeof tinyMCE !== "undefined") {
      tinyMCE.triggerSave();
    }
    /* get ajax response */
    var data = (element.hasClass('js_ajax-forms')) ? element.serialize() : element.find('select, textarea, input').serialize();
    $.post(ajax_path + url, data, function (response) {
      /* button reset */
      button_status(submit, "reset");
      /* handle response */
      if (response.error) {
        if (success.is(":visible")) success.hide(); // hide previous alert
        error.html(response.message).slideDown();
      } else if (response.success) {
        if (error.is(":visible")) error.hide(); // hide previous alert
        success.html(response.message).slideDown();
      } else {
        eval(response.callback);
      }
    }, "json")
      .fail(function () {
        /* button reset */
        button_status(submit, "reset");
        /* handle error */
        if (success.is(":visible")) success.hide(); // hide previous alert
        error.html(__['There is something that went wrong!']).slideDown();
      });
  }
  $('body').on('submit', '.js_ajax-forms', function (e) {
    e.preventDefault();
    _submitAJAXform($(this));
  });
  $('body').on('click', '.js_ajax-forms-html button[type="submit"]', function () {
    _submitAJAXform($(this).closest('.js_ajax-forms-html'));
  });


  // run load-more
  /* load more data by click */
  $('body').on('click', '.js_see-more', function () {
    load_more($(this));
  });
  /* load more data by scroll */
  $('.js_see-more-infinite').bind('inview', function (event, visible) {
    if (visible == true) {
      if ((desktop_infinite_scroll && $(window).width() >= 970) || (mobile_infinite_scroll && $(window).width() < 970)) {
        load_more($(this));
      }
    }
  });


  // run search
  /* show and get the search results */
  $('body').on('keyup', '#search-input', function () {
    var query = $(this).val();
    if (!is_empty(query)) {
      $('#search-history').hide();
      $('#search-results').show();
      var hashtags = query.match(/#(\w+)/ig);
      if (hashtags !== null && hashtags.length > 0) {
        var query = hashtags[0].replace("#", "");
        $('#search-results .dropdown-widget-header').hide();
        $('#search-results-all').hide();
        $('#search-results .dropdown-widget-body').html(render_template('#search-for', { 'query': query, 'hashtag': true }));
      } else {
        $.post(api['data/search'], { 'query': query }, function (response) {
          if (response.callback) {
            eval(response.callback);
          } else if (response.results) {
            $('#search-results .dropdown-widget-header').show();
            $('#search-results-all').show();
            $('#search-results .dropdown-widget-body').html(response.results);
            $('#search-results-all').attr('href', site_path + '/search/' + query);
          } else {
            $('#search-results .dropdown-widget-header').hide();
            $('#search-results-all').hide();
            $('#search-results .dropdown-widget-body').html(render_template('#search-for', { 'query': query }));
          }
        }, 'json');
      }
    }
  });
  /* submit search form */
  $('body').on('keydown', '#search-input', function (event) {
    if (event.keyCode == 13) {
      event.preventDefault;
      var query = $(this).val();
      if (!is_empty(query)) {
        var hashtags = query.match(/#(\w+)/ig);
        if (hashtags !== null && hashtags.length > 0) {
          var query = hashtags[0].replace("#", "");
          window.location = site_path + '/search/hashtag/' + query
        } else {
          window.location = site_path + '/search/' + query
        }
      }
      return false;
    }
  });
  /* show previous search (results|history) when the search-input is clicked */
  $('body').on('click', '#search-input', function () {
    if ($(this).val() != '') {
      $('#search-results').show();
    } else {
      $('#search-history').show();
    }
  });
  /* hide the search (results|history) when clicked outside search-input */
  $('body').on('click', function (e) {
    if (!$(e.target).is("#search-input")) {
      $('#search-results, #search-history').hide();
    }
  });
  /* submit search form */
  $('body').on('submit', '.js_search-form', function (e) {
    e.preventDefault;
    var query = this.query.value;
    var handle = $(this).data('handle');
    if (!is_empty(query)) {
      var filter = ($(this).data('filter') !== undefined) ? '/' + $(this).data('filter') : '';
      if (handle !== undefined) {
        window.location = site_path + '/' + handle + '/search/' + query + filter;
      } else {
        var hashtags = query.match(/#(\w+)/ig);
        if (hashtags !== null && hashtags.length > 0) {
          var query = hashtags[0].replace("#", "");
          window.location = site_path + '/search/hashtag/' + query;
        } else {
          window.location = site_path + '/search/' + query + filter;
        }
      }
    }
    return false;
  });


  // run YouTube player
  $('body').on('click', '.js_youtube-player', function () {
    $(this).html('<iframe src="https://www.youtube.com/embed/' + $(this).data('id') + '?autoplay=1" frameborder="0" allowfullscreen="1"></iframe>');
  });


  // run payments
  /* PayPal */
  $('body').on('click', '.js_payment-paypal', function () {
    var _this = $(this);
    var data = {};
    data['handle'] = _this.data('handle');
    if (data['handle'] == "packages") {
      data['package_id'] = _this.data('id');
    }
    if (data['handle'] == "wallet") {
      data['price'] = _this.data('price');
    }
    if (data['handle'] == "donate") {
      data['post_id'] = _this.data('id');
      data['price'] = _this.data('price');
    }
    /* button loading */
    button_status(_this, "loading");
    /* post the request */
    $.post(api['payments/paypal'], data, function (response) {
      /* button reset */
      button_status(_this, "reset");
      /* check the response */
      if (!response) return;
      /* check if there is a callback */
      if (response.callback) {
        eval(response.callback);
      }
    }, "json")
      .fail(function () {
        /* button reset */
        button_status(_this, "reset");
        /* handle error */
        modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
      });
  });
  /* Stripe */
  $('body').on('click', '.js_payment-stripe', function () {
    var _this = $(this);
    var method = _this.data('method');
    var data = {};
    data['handle'] = _this.data('handle');
    if (data['handle'] == "packages") {
      data['package_id'] = _this.data('id');
    }
    if (data['handle'] == "wallet") {
      data['price'] = _this.data('price');
    }
    if (data['handle'] == "donate") {
      data['post_id'] = _this.data('id');
      data['price'] = _this.data('price');
    }
    /* button loading */
    button_status(_this, "loading");
    var handler = StripeCheckout.configure({
      key: stripe_key,
      locale: 'english',
      image: _this.data('img') || '',
      token: function (token) {
        data['token'] = token.id;
        data['email'] = token.email;
        $.post(api['payments/stripe'], data, function (response) {
          /* button reset */
          button_status(_this, "reset");
          /* check the response */
          if (!response) return;
          /* check if there is a callback */
          if (response.callback) {
            eval(response.callback);
          }
        }, "json")
          .fail(function () {
            /* button reset */
            button_status(_this, "reset");
            /* handle error */
            modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
          });
      }
    });
    handler.open({
      name: site_title,
      description: _this.data('name') || '',
      amount: _this.data('price') * 100,
      currency: currency,
      alipay: (method == "alipay") ? true : false,
      opened: function () {
        _this.button('reset');
        $('#modal').modal('hide');
      }
    });
    $(window).on('popstate', function () {
      handler.close();
    });
  });
  /* Paystack */
  $('body').on('click', '.js_payment-paystack', function () {
    var _this = $(this);
    var data = {};
    data['handle'] = _this.data('handle');
    if (data['handle'] == "packages") {
      data['package_id'] = _this.data('id');
    }
    if (data['handle'] == "wallet") {
      data['price'] = _this.data('price');
    }
    if (data['handle'] == "donate") {
      data['post_id'] = _this.data('id');
      data['price'] = _this.data('price');
    }
    /* button loading */
    button_status(_this, "loading");
    /* post the request */
    $.post(api['payments/paystack'], data, function (response) {
      /* button reset */
      button_status(_this, "reset");
      /* check the response */
      if (!response) return;
      /* check if there is a callback */
      if (response.callback) {
        eval(response.callback);
      }
    }, "json")
      .fail(function () {
        /* button reset */
        button_status(_this, "reset");
        /* handle error */
        modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
      });
  });
  /* CoinPayments */
  $('body').on('click', '.js_payment-coinpayments', function () {
    var _this = $(this);
    var data = {};
    data['handle'] = _this.data('handle');
    if (data['handle'] == "packages") {
      data['package_id'] = _this.data('id');
    }
    if (data['handle'] == "wallet") {
      data['price'] = _this.data('price');
    }
    if (data['handle'] == "donate") {
      data['post_id'] = _this.data('id');
      data['price'] = _this.data('price');
    }
    /* button loading */
    button_status(_this, "loading");
    /* post the request */
    $.post(api['payments/coinpayments'], data, function (response) {
      /* button reset */
      button_status(_this, "reset");
      /* check the response */
      if (response.coinpayments_form) {
        $(response.coinpayments_form).appendTo('body').submit();
      }
      /* check if there is a callback */
      if (response.callback) {
        eval(response.callback);
      }
    }, "json")
      .fail(function () {
        /* button reset */
        button_status(_this, "reset");
        /* handle error */
        modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
      });
  });
  /* 2Checkout */
  $('body').on('submit', '#twocheckout_form', function (e) {
    e.preventDefault();
    TCO.loadPubKey("production", function () {
      twocheckout_token_request();
    });
    return false;
  });
  function twocheckout_token_request() {
    var form = $("#twocheckout_form");
    var submit = form.find('button[type="submit"]');
    var error = form.find('.alert.alert-danger');
    button_status(submit, "loading");
    if (form.find('input[name="card_number"]').val() != '' && form.find('input[select="card_exp_month"]').val() != '' && form.find('select[name="card_exp_year"]').val() != '' && form.find('input[name="card_cvv"]').val() != '' && form.find('input[name="billing_name"]').val() != '' && form.find('input[name="billing_email"]').val() != '' && form.find('input[name="billing_phone"]').val() != '' && form.find('input[name="billing_address"]').val() != '' && form.find('input[name="billing_city"]').val() != '' && form.find('input[name="billing_state"]').val() != '' && form.find('select[name="billing_country"]').val() != '' && form.find('input[name="billing_zip_code"]').val() != '') {
      /* setup token request arguments */
      var args = {
        sellerId: twocheckout_merchant_code,
        publishableKey: twocheckout_publishable_key,
        ccNo: form.find('input[name="card_number"]').val(),
        cvv: form.find('input[name="card_cvv"]').val(),
        expMonth: form.find('select[name="card_exp_month"]').val(),
        expYear: form.find('select[name="card_exp_year"]').val()
      };
      /* make the token request */
      TCO.requestToken(twocheckout_success_callback, twocheckout_error_callback, args);
    } else {
      button_status(submit, "reset");
      error.html(__['You must fill in all of the fields']).slideDown();
    }
  };
  function twocheckout_success_callback(data) {
    var form = $("#twocheckout_form");
    var submit = form.find('button[type="submit"]');
    var error = form.find('.alert.alert-danger');
    /* update token */
    form.find('input[name="token"]').val(data.response.token.token);
    /* get ajax response */
    $.post(api['payments/2checkout'], form.serialize(), function (response) {
      /* button reset */
      button_status(submit, "reset");
      /* handle response */
      if (response.error) {
        error.html(response.message).slideDown();
      } else {
        eval(response.callback);
      }
    }, "json")
      .fail(function () {
        /* button reset */
        button_status(submit, "reset");
        /* handle error */
        error.html(__['There is something that went wrong!']).slideDown();
      });
  };
  function twocheckout_error_callback(data) {
    var form = $("#twocheckout_form");
    var submit = form.find('button[type="submit"]');
    var error = form.find('.alert.alert-danger');
    if (data.errorCode === 200) {
      twocheckout_token_request();
    } else {
      button_status(submit, "reset");
      error.html(data.errorMsg).slideDown();
    }
  };
  /* Razorpay */
  $('body').on('submit', '#razorpay_form', function (e) {
    e.preventDefault();
    var form = $("#razorpay_form");
    var submit = form.find('button[type="submit"]');
    var error = form.find('.alert.alert-danger');
    button_status(submit, "loading");
    if (form.find('input[name="billing_name"]').val() != '' && form.find('input[name="billing_email"]').val() != '' && form.find('input[name="billing_phone"]').val() != '') {
      var data = {};
      data['handle'] = form.find('input[name="handle"]').val();
      if (data['handle'] == "packages") {
        data['package_id'] = form.find('input[name="id"]').val();
      }
      if (data['handle'] == "wallet") {
        data['price'] = form.find('input[name="price"]').val();
      }
      if (data['handle'] == "donate") {
        data['post_id'] = form.find('input[name="id"]').val();
        data['price'] = form.find('input[name="price"]').val();
      }
      var options = {
        "key": razorpay_key,
        "amount": form.find('input[name="price"]').val() * 100,
        "currency": currency,
        "name": site_title,
        "netbanking": true,
        "prefill": {
          "name": form.find('input[name="billing_name"]').val(),
          "email": form.find('input[name="billing_email"]').val(),
          "contact": form.find('input[name="billing_phone"]').val(),
        },
        "handler": function (transaction) {
          data['razorpay_payment_id'] = transaction.razorpay_payment_id;
          $.post(api['payments/razorpay'], data, function (response) {
            /* button reset */
            button_status(submit, "reset");
            /* check the response */
            if (!response) return;
            /* check if there is a callback */
            if (response.callback) {
              eval(response.callback);
            }
          }, "json")
            .fail(function () {
              /* button reset */
              button_status(submit, "reset");
              /* handle error */
              modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
            });
        },
      };
      var rzp1 = new Razorpay(options);
      rzp1.open();
    } else {
      button_status(submit, "reset");
      error.html(__['You must fill in all of the fields']).slideDown();
    }
  });
  /* Cashfree */
  $('body').on('submit', '#cashfree_form', function (e) {
    e.preventDefault();
    var form = $("#cashfree_form");
    var submit = form.find('button[type="submit"]');
    var error = form.find('.alert.alert-danger');
    button_status(submit, "loading");
    if (form.find('input[name="billing_name"]').val() != '' && form.find('input[name="billing_email"]').val() != '' && form.find('input[name="billing_phone"]').val() != '') {
      var data = {};
      data['handle'] = form.find('input[name="handle"]').val();
      if (data['handle'] == "packages") {
        data['package_id'] = form.find('input[name="id"]').val();
      }
      if (data['handle'] == "wallet") {
        data['price'] = form.find('input[name="price"]').val();
      }
      if (data['handle'] == "donate") {
        data['post_id'] = form.find('input[name="id"]').val();
        data['price'] = form.find('input[name="price"]').val();
      }
      data['billing_name'] = form.find('input[name="billing_name"]').val();
      data['billing_email'] = form.find('input[name="billing_email"]').val();
      data['billing_phone'] = form.find('input[name="billing_phone"]').val();
      /* post the request */
      $.post(api['payments/cashfree'], data, function (response) {
        /* button reset */
        button_status(submit, "reset");
        /* check the response */
        if (!response) return;
        /* check if there is a callback */
        if (response.callback) {
          eval(response.callback);
        }
      }, "json")
        .fail(function () {
          /* button reset */
          button_status(submit, "reset");
          /* handle error */
          modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
        });

    } else {
      button_status(submit, "reset");
      error.html(__['You must fill in all of the fields']).slideDown();
    }
  });
  /* Coinbase */
  $('body').on('click', '.js_payment-coinbase', function () {
    var _this = $(this);
    var data = {};
    data['handle'] = _this.data('handle');
    if (data['handle'] == "packages") {
      data['package_id'] = _this.data('id');
    }
    if (data['handle'] == "wallet") {
      data['price'] = _this.data('price');
    }
    if (data['handle'] == "donate") {
      data['post_id'] = _this.data('id');
      data['price'] = _this.data('price');
    }
    /* button loading */
    button_status(_this, "loading");
    /* post the request */
    $.post(api['payments/coinbase'], data, function (response) {
      /* button reset */
      button_status(_this, "reset");
      /* check the response */
      if (!response) return;
      /* check if there is a callback */
      if (response.callback) {
        eval(response.callback);
      }
    }, "json")
      .fail(function () {
        /* button reset */
        button_status(_this, "reset");
        /* handle error */
        modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
      });
  });
  /* SecurionPay */
  $('body').on('click', '.js_payment-securionpay', function () {
    var _this = $(this);
    var data = {};
    data['do'] = 'token';
    data['handle'] = _this.data('handle');
    if (data['handle'] == "packages") {
      data['package_id'] = _this.data('id');
    }
    if (data['handle'] == "wallet") {
      data['price'] = _this.data('price');
    }
    if (data['handle'] == "donate") {
      data['post_id'] = _this.data('id');
      data['price'] = _this.data('price');
    }
    /* button loading */
    button_status(_this, "loading");
    /* post the request */
    $.post(api['payments/securionpay'], data, function (response) {
      /* button reset */
      button_status(_this, "reset");
      /* check the response */
      if (!response) return;
      /* check if there is a callback */
      if (response.callback) {
        eval(response.callback);
      }
      SecurionpayCheckout.key = securionpay_key;
      SecurionpayCheckout.open({
        checkoutRequest: response.token,
        name: site_title,
      });
      SecurionpayCheckout.success = function (result) {
        data['do'] = 'verifiy';
        data['securionpay'] = result;
        $.post(api['payments/securionpay'], data, function (response) {
          /* check the response */
          if (!response) return;
          /* check if there is a callback */
          if (response.callback) {
            eval(response.callback);
          }
        }, "json")
          .fail(function () {
            /* handle error */
            modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
          });
      };
      SecurionpayCheckout.error = function (errorMessage) {
        /* handle error */
        modal('#modal-message', { title: __['Error'], message: errorMessage });
      };
    }, "json")
      .fail(function () {
        /* button reset */
        button_status(_this, "reset");
        /* handle error */
        modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
      });
  });
  /* Wallet */
  $('body').on('click', '.js_payment-wallet-package', function () {
    var _this = $(this);
    /* button loading */
    button_status(_this, "loading");
    /* post the request */
    $.post(api['payments/wallet'], { 'do': 'wallet_package_payment', 'package_id': _this.data('id') }, function (response) {
      /* button reset */
      button_status(_this, "reset");
      /* check the response */
      if (!response) return;
      /* check if there is a callback */
      if (response.callback) {
        eval(response.callback);
      }
    }, "json")
      .fail(function () {
        /* button reset */
        button_status(_this, "reset");
        /* handle error */
        modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
      });
  });
  /* Free Trial */
  $('body').on('click', '.js_try-package', function (e) {
    e.preventDefault;
    var id = $(this).data('id');
    confirm(__['Try Package'], __['Are you sure you want to subscribe to this free package?'], function () {
      $.post(api['payments/trial'], { 'package_id': id }, function (response) {
        /* check the response */
        if (response.callback) {
          eval(response.callback);
        }
      }, 'json')
        .fail(function () {
          modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
        });
    });
    return false;
  });


  // run ads campaigns
  $('body').on('click', '.js_ads-click-campaign', function () {
    var id = $(this).data('id');
    $.post(api['ads/click'], { 'id': id }, function (response) {
      if (response.callback) {
        eval(response.callback);
      }
    }, "json")
      .fail(function () {
        modal('#modal-message', { title: __['Error'], message: __['There is something that went wrong!'] });
      });
  });


  // handle theme mode
  if (theme_mode_night) {
    $('.table').addClass('table-dark');
  }
  $('body').on('click', '.js_theme-mode', function () {
    _this = $(this);
    mode = _this.data('mode');
    if (mode == "night") {
      $('body').addClass('night-mode');
      $('.table').addClass('table-dark');
      _this.data('mode', 'day');
      $('.js_theme-mode-text').text(__['Day Mode']);
      $('.js_theme-mode-icon').removeClass("fa-moon").addClass("fa-sun");
      $.post(api['core/theme'], { 'mode': mode });

    } else {
      $('body').removeClass('night-mode');
      $('.table').removeClass('table-dark');
      _this.data('mode', 'night');
      $('.js_theme-mode-text').text(__['Night Mode']);
      $('.js_theme-mode-icon').removeClass("fa-sun").addClass("fa-moon");
      $.post(api['core/theme'], { 'mode': mode });
    }
  });

});