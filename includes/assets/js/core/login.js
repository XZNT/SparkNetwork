$(function () {

  $('body').on('click', '.js_chat-start, .js_friend-add, .js_follow, .js_like-page, .js_join-group, .js_go-event, .js_interest-event, .js_job-apply', function () {
    modal('#modal-login');
  });

});