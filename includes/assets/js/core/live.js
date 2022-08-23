
// initialize live global vars
var live_post_id;
var live_realtime_thread;
var live_realtime_process = false;
var live_streaming_process = false;

// initialize live tracks vars
var localTracks = {
  videoTrack: null,
  audioTrack: null
};
var localTrackState = {
  videoTrackEnabled: true,
  audioTrackEnabled: true
}


// join
async function join() {
  /* init agora client */
  agora_client.setClientRole("host");
  await agora_client.join(agora_app_id, agora_channel_name, agora_token, agora_uid);
  /* create local audio and video tracks */
  localTracks.audioTrack = await AgoraRTC.createMicrophoneAudioTrack();
  localTracks.videoTrack = await AgoraRTC.createCameraVideoTrack();
  /* play local video track */
  localTracks.videoTrack.play("js_live-video");
  /* publish local tracks to channel */
  await agora_client.publish(Object.values(localTracks));
}


// leave
async function leave() {
  for (trackName in localTracks) {
    var track = localTracks[trackName];
    if (track) {
      track.stop();
      track.close();
      localTracks[trackName] = undefined;
    }
  }
  /* leave the channel */
  await agora_client.leave();
}


// mute_audio
async function mute_audio() {
  if (!localTracks.audioTrack) return;
  await localTracks.audioTrack.setEnabled(false);
  localTrackState.audioTrackEnabled = false;
}


// unmute_audio
async function unmute_audio() {
  if (!localTracks.audioTrack) return;
  await localTracks.audioTrack.setEnabled(true);
  localTrackState.audioTrackEnabled = true;
}


// mute_video
async function mute_video() {
  if (!localTracks.videoTrack) return;
  await localTracks.videoTrack.setEnabled(false);
  localTrackState.videoTrackEnabled = false;
}


// unmute_video
async function unmute_video() {
  if (!localTracks.videoTrack) return;
  await localTracks.videoTrack.setEnabled(true);
  localTrackState.videoTrackEnabled = true;
}


// end live
function end_live_host() {
  if (!live_streaming_process) {
    return;
  }
  /* update live streaming process */
  live_streaming_process = false;
  /* leave the live channel */
  leave();
  /* update live status */
  show_live_status();
  $('#js_live-status').html('<i class="fas fa-info-circle mr5"></i>' + __['You are offline now']).addClass("info");
  hide_live_status();
  /* clear live real-time thread */
  clearInterval(live_realtime_thread);
  /* reset live realtime process */
  live_realtime_process = false;
  /* handle the live buttons */
  $('#js_live-start').show();
  $('#js_live-end').hide();
  /* handle stream buttons */
  $('#js_live-stream-buttons').hide();
  /* handle live counter */
  $('#js_live-counter-status').html(__['Offline']).addClass("offline");
  $('#js_live-counter-number').html(0);
  /* handle live recording */
  $('#js_live-recording').hide();
  /* update the server side */
  $.post(api['live/reaction'], { 'do': 'end', 'post_id': live_post_id }, 'json');
  /* update live_post_id */
  live_post_id = undefined;
  /* remove live comments */
  $('#live-comments').find('ul.js_scroller').html('');
  /* handle button status */
  button_status($('#js_live-end'), "reset");
}


// show live status
function show_live_status() {
  $('#js_live-status').removeAttr("style").removeClass("success error info").show();
}


// hide live status
function hide_live_status() {
  setTimeout(function () {
    $('#js_live-status').animate({ bottom: '0px', opacity: '0' });
  }, '2500');
}


// capture video thumbnail
function capture_video_thumbnail() {
  /* get video */
  var video = $("#js_live-video").find("video")[0];
  /* set canvas */
  var canvas = document.createElement("canvas");
  canvas.width = video.videoWidth;
  canvas.height = video.videoHeight;
  canvas.getContext('2d').drawImage(video, 0, 0);
  /* return */
  return canvas.toDataURL('image/png');
}


$(function () {

  // get user camera and mic permission
  if (!(navigator.mediaDevices && navigator.mediaDevices.getUserMedia)) {
    /* update live status */
    $('#js_live-status').html('<i class="fas fa-exclamation-circle mr5"></i>' + __['Sorry, WebRTC is not available in your browser']).addClass("error");
  } else {
    /* update live status */
    $('#js_live-status').html('<i class="fas fa-info-circle mr5"></i>' + __['You are ready to Go Live now']).addClass("info");
    /* handle the live buttons */
    $('#js_live-start').show();
  }


  // start live stream
  $('body').on('click', '#js_live-start', async function () {
    var _this = $(this);
    /* handle button status */
    button_status($('#js_live-start'), "loading");
    /* update live status */
    show_live_status();
    $('#js_live-status').html(__['Going Live'] + '<span class="spinner-grow spinner-grow-sm ml10"></span>');
    await join();
    /* take video thumbnail */
    var video_thumbnail = capture_video_thumbnail();
    /* update the server side */
    $.post(api['live/reaction'], { 'do': 'start', 'agora_uid': agora_uid, 'agora_token': agora_token, 'agora_channel_name': agora_channel_name, 'video_thumbnail': video_thumbnail, 'node': _this.data('node'), 'node_id': _this.data('node-id') }, function (response) {
      /* update live_post_id */
      live_post_id = response.post_id;
      /* update live streaming process */
      live_streaming_process = true;
      /* update live status */
      $('#js_live-status').html('<i class="fas fa-check mr5"></i>' + __['You are live now']).addClass("success");
      hide_live_status();
      /* handle the live buttons */
      $('#js_live-start').hide();
      $('#js_live-end').show();
      /* handle stream buttons */
      $('#js_live-stream-buttons').show();
      $("#mic-btn").removeAttr("disabled");
      $("#cam-btn").removeAttr("disabled");
      $("#comments-btn").removeAttr("disabled");
      /* handle live counter */
      $('#js_live-counter-status').html(__['Online']).removeClass("offline");
      /* handle live recording */
      $('#js_live-recording').show();
      /* set live real-time thread */
      live_realtime_thread = setInterval(function () {
        /* check live realtime process */
        if (live_realtime_process) {
          return;
        }
        /* set live realtime process */
        live_realtime_process = true;
        var last_comment_id = $("#live-comments").find("ul.js_scroller .comment:last").data('id') || 0;
        $.post(api['live/reaction'], { 'do': 'stats', 'post_id': live_post_id, 'last_comment_id': last_comment_id }, function (response) {
          /* update live count */
          $('#js_live-counter-number').html(response.live_count);
          /* update comments */
          if (response.comments) {
            $('#live-comments').find('ul.js_scroller').append(response.comments);
            $('#live-comments').find('ul.js_scroller').scrollTop($('#live-comments').find('ul.js_scroller')[0].scrollHeight);
          }
          /* reset live realtime process */
          live_realtime_process = false;
        }, 'json');
      }, 5000);
      /* handle button status */
      button_status($('#js_live-start'), "reset");
    }, 'json');
  });


  // end live stream
  $('body').on('click', '#js_live-end', function () {
    /* handle button status */
    button_status($('#js_live-end'), "loading");
    end_live_host();
  });
  /* handle closing the window */
  $(window).on('beforeunload', function () {
    end_live_host();
    return true;
  });


  // mute mic
  $('body').on('click', '.js_mute-mic, .js_unmute-mic', function () {
    var _this = $(this);
    var _do = ($(this).hasClass("js_mute-mic")) ? "mute" : "unmute";
    if (_do == "mute") {
      mute_audio();
      _this.removeClass('js_mute-mic btn-secondary').addClass('js_unmute-mic btn-danger');
      _this.find("i").removeClass("fa-microphone").addClass("fa-microphone-slash");
    } else {
      unmute_audio();
      _this.removeClass('js_unmute-mic btn-danger').addClass('js_mute-mic btn-secondary');
      _this.find("i").removeClass("fa-microphone-slash").addClass("fa-microphone");
    }
  });


  // mute cam
  $('body').on('click', '.js_mute-cam, .js_unmute-cam', function () {
    var _this = $(this);
    var _do = ($(this).hasClass("js_mute-cam")) ? "mute" : "unmute";
    if (_do == "mute") {
      mute_video();
      _this.removeClass('js_mute-cam btn-secondary').addClass('js_unmute-cam btn-danger');
      _this.find("i").removeClass("fa-video").addClass("fa-video-slash");
    } else {
      unmute_video();
      _this.removeClass('js_unmute-cam btn-danger').addClass('js_mute-cam btn-secondary');
      _this.find("i").removeClass("fa-video-slash").addClass("fa-video");
    }
  });


  // mute comments
  $('body').on('click', '.js_mute-comments, .js_unmute-comments', function () {
    var _this = $(this);
    var _do = ($(this).hasClass("js_mute-comments")) ? "mute" : "unmute";
    if (_do == "mute") {
      _this.removeClass('js_mute-comments btn-secondary').addClass('js_unmute-comments btn-danger');
      _this.find("i").removeClass("fa-comments").addClass("fa-comment-slash");
      $('#live-comments').hide();
    } else {
      _this.removeClass('js_unmute-comments btn-danger').addClass('js_mute-comments btn-secondary');
      _this.find("i").removeClass("fa-comment-slash").addClass("fa-comments");
      $('#live-comments').show();
    }
  });

});