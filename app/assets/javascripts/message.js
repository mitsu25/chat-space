$(function() {

  function getUrlWithGroupId(){
    var groupId  = $('.group_id').attr('value');
    var url      = '/groups/' + groupId + '/messages';
    return url
  }

  function buildHTML(data) {
    var itemName    = '<li class="main__chat_area__chat_content__name">' + data.userName + '</li>';
    var itemTime    = '<li class="main__chat_area__chat_content__date">' + data.createdAt + '</li>';
    var itemBody    = '<li class="main__chat_area__chat_content__text">' + data.body + '</li>';

    if (data.image.url === null) {
      var messageList = '<ul class="main__chat_area__chat_cotentt">' + itemName + itemTime + itemBody + '</ul>';
    } else {
      var imageTag    = '<img src="' + data.image.url + '">'
      var itemImage   = '<li class="main__chat_area__chat_content__image">' + imageTag +'</li>';
      var messageList = '<ul class="main__chat_area__chat_cotentt">' + itemName + itemTime + itemBody + itemImage + '</ul>';
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

});
