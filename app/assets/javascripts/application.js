// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery-ui
//= require activestorage
//= require turbolinks
//= require materialize
//= require_tree .

// モーダルの初期化
$(document).ready(function(){
    $('.modal').modal();
});
// ヘッダーのドロップダウン初期化
$( document ).ready(function(){
  $(".dropdown-trigger").dropdown();
});
// ドラッグ&ドロップ
$( document ).ready(function() {
  $('.item').draggable();
  $('.drop_area').droppable({
    activate: function(e,ui) {
      $(this)

    },
    over: function(e,ui) {
      $(this)
        .css('background', '#eceff1')
    },
    out: function(e,ui) {
      $(this)
        .css('background', '#ffffff')
    },
    drop: function(e,ui) {
      $(this)
        .addClass("ui-state-highlight")
        .css('background', '#e0e0e0')

        var comment_id = ui.draggable.attr('name');
        var place_status = $(this).attr('id');
        // ui.draggabledされた　.attr 指定した属性の値を取得

        $('#update_comment_id').val(comment_id);
        $('#update_place_status').val(place_status);
        // 上記で取得した値を戻り値として設定

        // Ajax通信を開始
        $.ajax({
          url: '/place_status_update', // アクセス先パス
          type: 'POST', //通信に利用するHTTPメソッド (デフォルトGET)
          data: $('#status_update_form').serialize() //送信するデータ
        })
        // Ajaxリクエストが成功した時
        .done((data) => {
            let id = parseInt(data.id);
            let user_id = parseInt(data.user_id);
            let nick_name = data.nick_name;
            let comment = data.comment;
            let group_id = parseInt(data.group_id);
            let user_image = data.user_image; // imageの受け取り方不明
            let place_status = data.place_status;
            let right = data.right;
            changeDom(id,user_id,nick_name,comment,group_id,user_image,place_status,right);
        })
        // Ajaxリクエストが失敗した時
        .fail((data) => {
          window.alert('エラーが発生しました。');
        });
        // Ajaxリクエストが成功・失敗どちらでも発動
        // .always(function(data) => {
        // });
        // DOM操作用のfunction
        function changeDom(id,user_id,nick_name,comment,group_id,user_image,place_status,right){
          $("#" + place_status).find('.item').each( function( index, element ) {
            //console.log( element );
            $(element).before('<div class=“col s4 kpt_comments item ui-draggable ui-draggable-handle” name=“41" style=“position: relative;“>あいりKのコメント２<i class=“material-icons” style=“color: red”>thumb_up</i><span name=“3">3それな</span></a></div>')
            return false;
//console.log( $(element).find(".rights_count"));
            })
          // 挿入先判定のため要素分だけループ処理
          // $('#tbodysamaya tr').each(function(index,element){
          //     if(parseInt($(element).attr('id'))<= age){
                  // 取得したelementのid(age)が登録したAgeより小さい場合にその手前に登録したuserのhtmlを挿入する。
                  // $(element).before('<td>'+name+'</td><td>'+age+'</td><td>'+name+'</td>');
                  // 処理完了のためループ処理を抜ける
                  // return false;
              // }
          // });
      }
    }
  });
});
