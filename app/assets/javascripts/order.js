$( document ).ready(function() {
  $('#order-submit-btn').click(function(){
    $(this).hide();
    $('.order-submit').prepend("Submitting...");
  });
});