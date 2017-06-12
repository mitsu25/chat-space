$(function() {

  function buildHTML(data) {
    var itemName = '<li class="main__chat_area__chat_content__name">' + data.userName + '</li>';
    var itemTime = '<li class="main__chat_area__chat_content__date">' + data.createdAt + '</li>';
    var itemBody = '<li class="main__chat_area__chat_content__text">' + data.body + '</li>';
    if (data.image.url === null) {
      var messageList = '<ul class="main__chat_area__chat_cotentt">' + itemName + itemTime + itemBody + '</ul>';
    } else {
      var image     = '<img src="' + data.image.url + '">'
      var itemImage = '<li class="main__chat_area__chat_content__image">' + image +'</li>';
      var messageList = '<ul class="main__chat_area__chat_cotentt">' + itemName + itemTime + itemBody + itemImage + '</ul>';
    }
    return messageList;
  }

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var form = $(this).get(0);
    var formData = new FormData(form);
    var groupId = $('.group_id').attr('value');
    var url = '/groups/' + groupId + '/messages.json';

    $.ajax({
      type: 'POST',
      url: url,
      dataType: 'json',
      data: formData,
      processData: false,
      contentType: false,
    })
    .done(function(data){
      e.preventDefault();
      var html = buildHTML(data);
      $('.main__chat_area').append(html);
      $('.main__posting_area__form').val("");
      $('#message_image').val("");
      $('.main__chat_area').animate({scrollTop: $('.main__chat_area').get(0).scrollHeight
        }, { duration: 'slow' } );
      $('.main__posting_area__button').removeAttr("disabled");
    })
    .fail(function(){
      alert('error');
    });
  });

});
