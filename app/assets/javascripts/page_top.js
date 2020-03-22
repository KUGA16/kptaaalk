jQuery(function() {
  var pagetop = $('#page_top');
  pagetop.hide();
  $(window).scroll(function() {
    if ($(this).scrollTop() > 500) {
        pagetop.fadeIn();
    } else {
        pagetop.fadeOut();
    }
  });
  pagetop.click(function () {
    $('body,html').animate({
        scrollTop: 0
    }, 800);
    return false;
  });
});
