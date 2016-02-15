$(window).scroll(function(){
  if ($(".navbar").offset().top > 20) {
    $(".navbar-fixed-top").addClass("top-nav-scroll");
    $(".navbar-fixed-top").removeClass("top-nav-scroll-reverse");
  } else {
    $(".navbar-fixed-top").removeClass("top-nav-scroll");
    $(".navbar-fixed-top").addClass("top-nav-scroll-reverse");
  }
});

