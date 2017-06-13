$(function(){

  function buildHtmlForUserSearch(userData){
    var userName = `<p class="chat-group-user__name">${ userData.name }</p>`
    var addTag = `<a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ userData.id }" data-user-name="${ userData.name }">追加</a>`
    var html = '<div class="chat-group-user clearfix">' + userName + addTag + '</div>';
    return html;
  }

  function buildHtmlForSelectedUser(userId,userName){
    var idTag = `<input name = "group[user_ids][]", type ="hidden", value = ${ userId } >`;
    var userNameTag = `<p class="chat-group-user__name"> ${ userName } </p>`;
    var removeButton = '<a class="user-search-add chat-group-user__btn chat-group-user__btn--remove" >削除</a>'
    var html = '<div class="chat-group-user clearfix">' + idTag + userNameTag + removeButton + '</div>';
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

            $('.chat-group-user__btn--add').on('click', function(){
              var userId = $(this).attr('data-user-id');
              var userName = $(this).attr('data-user-name');
              var html = buildHtmlForSelectedUser(userId, userName);
              $('#chat-group-users').append(html);
              $('.chat-group-user__btn--remove').on('click', function(){
                $(this).parent().remove();
              });
              $(this).parent().remove();
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
