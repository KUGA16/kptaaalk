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
          .css('background', '#fdf5e6')
          .css('border', '2px solid #ffa07a')
console.log(this);
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
            console.log(data);
          })
          // Ajaxリクエストが失敗した時
          .fail((data) => {
            window.alert('正しい結果を得られませんでした。');
          });
          // Ajaxリクエストが成功・失敗どちらでも発動
          // .always(function(data) => {
          // });
      }
  });
});
