$(window).scroll(function(){
  if ($(".navbar-main").offset().top > 20) {
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

  // if ($(".navbar-landing").offset().top > 20) {
  //   $(".navbar-fixed-top").addClass("top-nav-scroll-landing");
  //   $(".navbar-fixed-top").removeClass("top-nav-scroll-reverse-landing");
  //   $(".merlots-logo-white-landing").css('display', 'none');
  //   $(".merlots-logo-color-landing").css('display', 'block');
  // } else {
  //   $(".navbar-fixed-top").removeClass("top-nav-scroll-landing");
  //   $(".navbar-fixed-top").addClass("top-nav-scroll-reverse-landing");
  //   $(".merlots-logo-white-landing").css('display', 'block');
  //   $(".merlots-logo-color-landing").css('display', 'none');
  // }
});

