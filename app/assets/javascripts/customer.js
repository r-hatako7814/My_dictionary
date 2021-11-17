// $(function() {
//   console.log("test")

// });



// $(function() {

// $('#js-search-form').on('keyup', function(e){
//   var input = $("#js-search-form").val();
  
//   $.ajax({
//       type: 'GET',
//       url : '/customers/my_dictionary',
//       date: {keyword: input},
//       dataType: 'json'
//   })
  
//   .done(function(contributions){
    
//     if (input.length === 0) {
//       $('#contribution-search-result').empty();
//     }
    
//     else if (input.length !== 0){
//       $('#contribution-search-result').empty();
//       contributions.forEach(function(contribution){
//         appendContribution(contribution)
//       });
//     }
    
//     else {
//       $('#contribution-search-result').empty();
//       appendErrMsgToHTML("一致する内容は見つかりません");
//     }
//   })
// });
// });
// // $(function() {
//   .fail(function() {
//     alert('検索に失敗しました');
//   });











// $(document).on('turbolinks:load', function(){

//     var search_list = $("#contribution-search-result");
//     var member_list = $("#member-append");

//     function appendContribution(contribution){
//         var html = 
//                     `<div class="contributions-search clearfix">
//                         <p class="contribution-search__title">${contribution.title}</p>
//                         <div class="contribution-search-add contribution-search__btn contribution-search__btn--add" data-contribution-id=${contribution.id} data-contribution-title=${contribution.title}>追加</div>
//                     </div>`;
//                     search_list.append(html);
//     }

//     function appendErrMsgToHTML(msg){
//         var html = 
//                     `<div class="contribution-search clearfix">
//                         <p class="contribution-search__title">${msg}</p>
//                     </div>`;
//                     search_list.append(html);
//     }