
//日付から文字列に変換する関数
function getStringFromDate(date) {

 var year_str = date.getFullYear();
 //月だけ+1すること
 var month_str = ("0" + (1 + date.getMonth())).slice(-2);
 var day_str = ("0" + date.getDate()).slice(-2);
 var hour_str = ("0" + date.getHours()).slice(-2);
 var minute_str = ("0" + date.getMinutes()).slice(-2);
 var second_str = ("0" + date.getSeconds()).slice(-2);


 format_str = 'YYYY-MM-DD hh:mm:ss';
 format_str = format_str.replace(/YYYY/g, year_str);
 format_str = format_str.replace(/MM/g, month_str);
 format_str = format_str.replace(/DD/g, day_str);
 format_str = format_str.replace(/hh/g, hour_str);
 format_str = format_str.replace(/mm/g, minute_str);
 format_str = format_str.replace(/ss/g, second_str);

 return format_str;
};

function contributionMsgToHTML(contribution) {
  var search_list = $(".show_search_result table tbody");
  var time = new Date(contribution.created_at);
  time = getStringFromDate(time);

  var html = `<tr>
                <td>${contribution.title}</td>
                <td>${contribution.body}</td>
                <td>${time}</td>
                <td>
                  <a class = "btn btn-sm btn-primary" href = "/contributions/${contribution.id}">
                    詳細へ
                  </a>
                </td>
                <td>
                  ♡${contribution.favorite.length}いいね
                </td>

              </tr>`;
                // ↓強制的にいいねを押せるようにはできるけど条件分岐が必要になる
                // <td>
                //   <a class="favorite-btn-${contribution.id}" data-remote="true" rel="nofollow" data-method="post" href="/contributions/${contribution.id}/favorites">
                //     ♡${contribution.favorite.length}いいね
                //   </a>
                // </td>
    search_list.append(html);
}
function appendErrMsgToHTML(msg) {
  var search_list = $(".show_search_result table");
  var html = `<div class='name'>${ msg }</div>`
  search_list.after(html);
}


$(document).on("turbolinks:load", function() {
  $('#show_search_keyword').on('keyup', function(){
    var input = $("#show_search_keyword").val();

    $.ajax({
        type: 'GET',
        url : '/increment_show_search',
        data: {keyword: input},
        dataType: 'json'
    })
    .done(function(contributions){
      $(".show_search_result").empty();
      if (contributions.length !== 0) {
        $(".show_search_result").html(' <table class = "text-center" style = "width:100%;"> <thead><tr><td>記述内容</td><td>意味</td><td>記述日</td><td>詳細</td></tr></thead><tbody></tbody></table>')
        $(".show_search_result table tbody").html(null);
        contributions.forEach(function(contribution){
        contributionMsgToHTML(contribution);
        });
      }
      else{
      $(".show_search_result").empty();
      $(".show_search_result").html(' <table class = "text-center" style = "width:100%;"> <thead><tr><td>記述内容</td><td>意味</td><td>記述日</td><td>詳細</td></tr></thead><tbody></tbody></table>')
      appendErrMsgToHTML("一致する投稿がありません");
      }
    })
    .fail(function(){
      alert("error")
    });
  });
});