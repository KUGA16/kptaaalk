// ドラッグ&ドロップ jquery-uiで実装
$( document ).ready(function() {
  $('.item').draggable();
  // drop_area以外にドロップされた場合 :not()
  $(":not(.drop_area)").droppable( {
    drop: function(e, ui) {
      // id itemにstyleを適応　relative は移動するときの基準が元いた位置
      $('.item').attr('style', 'position: relative;');
    }
  });
  // drop_areaにドロップされた場合
  $('.drop_area').droppable( {
    drop: function(e, ui) {
      $(this)
        .addClass("ui-state-highlight")

        // comment一つ一つにnameクラスを取得(comment.id)
        let comment_id = ui.draggable.attr('name');
        // ui.draggabledされた　.attr 指定した属性の値を取得
        let place_status = $(this).attr('id');

        // 上記で取得した値を戻り値として設定
        $('#update_comment_id').val(comment_id);
        $('#update_place_status').val(place_status);

        // Ajax通信を開始
        $.ajax({
          url: '/place_status_update', // アクセス先パス
          type: 'POST', //通信に利用するHTTPメソッド (デフォルトGET)
          data: $('#status_update_form').serialize() //送信するデータ
          // Ajaxリクエストが成功した時
          }).done((data) => {
              if (data) {
                let com = ui.draggable;
                ui.draggable.remove();
                changeDom(data.place_status, com);
              }
            // Ajaxリクエストが失敗した時
          }).fail((data) => {
            window.alert('エラーが発生しました。');
            // Ajaxリクエストが成功・失敗どちらも発動
          }).always(() => {　　
            $('.item').attr('style', 'position: relative;');
            $('.item').draggable();
          });
    }
  });
});

// DOM操作用のfunction
function changeDom(place_status, com) {
  // 自分以外のそれな数を全て大きいと設定する
  let isAllMoreThan = true;
  // 一つ一つの投稿のそれな数をint型に変更して代入
  let fav_count = parseInt($(com).attr('data-count'));
  $('#' + place_status).find('.item').each(function(index, element){
    if (parseInt($(element).attr('data-count')) <= fav_count){
      $(element).before(com);
      isAllMoreThan = false;
      return false;
    }
  });
  if(isAllMoreThan) {
    $('#' + place_status).append(com);
  }
}
