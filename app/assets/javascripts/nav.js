$(window).scroll(function(){
  if ($(".navbar").offset().top > 20) {
    $(".navbar-fixed-top").addClass("top-nav-scroll");
    $(".navbar-fixed-top").removeClass("top-nav-scroll-reverse");
    $(".merlots-logo-white").css('display', 'none');
    $(".merlots-logo-color").css('display', 'block');
  } else {
    $(".navbar-fixed-top").removeClass("top-nav-scroll");
    $(".navbar-fixed-top").addClass("top-nav-scroll-reverse");
    $(".merlots-logo-white").css('display', 'block');
    $(".merlots-logo-color").css('display', 'none');
  }
});

