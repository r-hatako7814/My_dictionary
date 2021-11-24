$(document).on("turbolinks:load", function() {
  $("#index_search_keyword").on("keyup",function() {
    keyword = $(this).val()
    const dataList = function(request, response) {
      $.ajax({
        url: '/autocomplete_index_search?' + "keyword=" + keyword,
        dataType: 'json',
        type: 'GET',
        cache: true,
        success: function(data) {
          response(data);
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
          response(['']);
        }
      });
    }


    $('#index_search_keyword').autocomplete({
      source: dataList,
      autoFocus: true,
      delay: 300,
      minLength: 2,
      maxlength: 5
    })
  });
});