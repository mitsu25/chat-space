$(function(){

  function buildHtmlForUserSearch(data){
    var userName = `<p class="chat-group-user__name">${data.name}</p>`
    var addTag = `<a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${data.id}" data-user-name="${data.name}">追加</a>`
    var html = '<div class="chat-group-user clearfix">' + userName + addTag + '</div>';
    return html;
  }

  var preKeyWord;

  $('#user-search-field').on('keyup', function(e){
      e.preventDefault();
      console.log(preKeyWord);

      console.log("event on");
      var input = $(this).val();
      var keyWord = input.replace(/ /g,"");
      if (keyWord != preKeyWord) {
        $('#user-search-result').find('.chat-group-user').remove()

        if(keyWord.length !== 0) {
          $.ajax({
            type: 'GET',
            url : '/users',
            dataType : 'json',
            data     : {
              user: {
                name: keyWord
              }
            }
          })
          .done(function(data){
            e.preventDefault();
            $.each(data,function(i,aData){
              var html = buildHtmlForUserSearch(aData);
              $('#user-search-result').append(html);
            });
          })
          .fail(function(){
            alert('error');
          });
        }
      }
      preKeyWord = keyWord;
  });

});
