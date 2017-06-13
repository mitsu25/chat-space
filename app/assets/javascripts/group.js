$(function(){

  function buildHtmlForUserSearch(userData){
    var userName = `<p class="chat-group-user__name">${ userData.name }</p>`
    var addTag = `<a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ userData.id }" data-user-name="${ userData.name }">追加</a>`
    var html = '<div class="chat-group-user clearfix">' + userName + addTag + '</div>';
    return html;
  }

  var preKeyWord;

  $('#user-search-field').on('keyup', function(e){
      e.preventDefault();

      var input = $(this).val();
      var keyWord = input.replace(/ /g,"");
      var searchResultList = $('#user-search-result');
      if (keyWord != preKeyWord){
        searchResultList.find('.chat-group-user').remove()

        if(keyWord.length !== 0){
          $.ajax({
            type: 'GET',
            url : '/users/search',
            dataType : 'json',
            data     : {
              user: {
                name: keyWord
              }
            }
          })
          .done(function(data){
            e.preventDefault();
            $.each(data, function(i, userData){
              var html = buildHtmlForUserSearch(userData);
              searchResultList.append(html);
            });
          })
          .fail(function(){
            alert('ユーザー検索に失敗しました');
          });
        }
      }
      preKeyWord = keyWord;
  });

});
