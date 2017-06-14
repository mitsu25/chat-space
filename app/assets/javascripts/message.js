$(function() {

  // メソッド定義
  function getGroupId(){
    var groupId  = $('.group_id').attr('value');
    return groupId
  }

  function getUrlWithGroupId(){
    var url      = '/groups/' + getGroupId() + '/messages';
    return url
  }

  function buildHTML(data) {
    var itemName    = '<li class="main__chat_area__chat_content__name">' + data.userName + '</li>';
    var itemTime    = '<li class="main__chat_area__chat_content__date">' + data.createdAt + '</li>';
    var itemBody    = '<li class="main__chat_area__chat_content__text">' + data.body + '</li>';

    if (data.image.url === null) {
      var messageList = '<ul class="main__chat_area__chat_cotent" data-message-id="${message.id}" >' + itemName + itemTime + itemBody + '</ul>';
    } else {
      var imageTag    = '<img src="' + data.image.url + '">'
      var itemImage   = '<li class="main__chat_area__chat_content__image">' + imageTag +'</li>';
      var messageList = '<ul class="main__chat_area__chat_cotent" data-message-id="${message.id}" >' + itemName + itemTime + itemBody + itemImage + '</ul>';
    }
    return messageList;

  }

  function clearFormValues() {
    $('.main__posting_area__form').val("");
    $('#message_image').val("");
  }

  function messageScroll() {
    $('.main__chat_area').animate({scrollTop: $('.main__chat_area').get(0).scrollHeight}, { duration: 'slow' } );
  }

  var reload = function(e){
    console.log("relodaメソッド発火");
    var id = $('.main__chat_area__chat_cotent:last').attr("data-message-id");
    var reloadUrl = getUrlWithGroupId() + '/reload'
    console.log("URL作成" + reloadUrl);
    $.ajax({
      type        : 'GET',
      url         :  reloadUrl,
      dataType    : 'json',
      data        : { user_id : getGroupId() }
    })
    .done(function(data){
    console.log("アクションからのレスポンス受け取り");
      $.each(data, function(i, message){
        console.log("受け取ったJSONデータの配列を処理中");
        if( message.id > id){
          $('.main__chat_area').append(buildHTML(message));
          messageScroll();
        }
      });
      console.log("更新完了");
    })
    .fail(function(){
      alert('自動更新に失敗しました');
    });
  }

  // イベント
  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var form     = $(this).get(0);
    var formData = new FormData(form);
    var url      = getUrlWithGroupId();

    $.ajax({
      type        : 'POST',
      url         : url,
      dataType    : 'json',
      data        : formData,
      processData : false,
      contentType : false,
    })
    .done(function(data){
      e.preventDefault();
      $('.main__chat_area').append(buildHTML(data));
      clearFormValues();
      messageScroll();
      $('.main__posting_area__button').removeAttr("disabled");
    })
    .fail(function(){
      alert('error');
    });
  });

  var autoReload = setInterval(function(){
    if (window.location.href.match(/\/groups\/\d+\/messages/)){
      reload();
    } else {
      clearInterval(autoReload);
    }
  }, 5000);

});
