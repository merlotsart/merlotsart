$(window).ready(function(){
  var groupon = 0;
  var byob = 0;
  var wine = 0;
  var mimosas = 0;
  var upgrade = 0;
  var currPrice = parseInt($('.class-price').html());
  var qty = parseInt($('.qty').val());

  $('.groupon-user').hide();
  $('.byob-user').hide();

  $('html').on('submit', 'form', function (e) {
    if (groupon > qty) {
      e.preventDefault();
    }
  });

  $('.groupon-coupon').change(function() {
      if ($(this).is(":checked")) {
        $('.groupon-user').slideDown();
      } else if ($(this).not(":checked")) {
        $('.groupon-user').slideUp();
        groupon = 0;
        $('.groupon_count').val("0");
      }
    });

  $('html').on('change', '.groupon_count', function(){
    groupon = parseInt($(this).val());
    if (groupon > qty) {
      alert("You have choosen a Groupon quantity greater than the ticket quantity. Please make sure select the correct amount of tickets. Failure to do so may result in space not being available");
    }
  });

  $('html').on('change', '.qty', function(){
    if (groupon > qty) {
      alert("You have choosen a Groupon quantity greater than the ticket quantity. Please make sure select the correct amount of tickets. Failure to do so may result in space not being available");
    }
  });

  $('.byob-fee').change(function() {
      if ($(this).is(":checked")) {
        byob = parseInt($('#byob').val());
        $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
      } else if ($(this).not(":checked")) {
        byob = 0;
        $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
      }
    });

  $('.voucher-upgrade').change(function() {
      if ($(this).is(":checked")) {
        upgrade = parseInt($('#voucher-upgrade').val());
        $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
      } else if ($(this).not(":checked")) {
        upgrade = 0;
        $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
      }
    });

  $('.wine').change(function() {
      if ($(this).is(":checked")) {
        wine = parseInt($('#wine').val());
        $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
      } else if ($(this).not(":checked")) {
        wine = 0;
        $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
      }
    });

  $('.mimosas').change(function() {
      if ($(this).is(":checked")) {
        mimosas = parseInt($('#mimosas').val());
        $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
      } else if ($(this).not(":checked")) {
        mimosas = 0;
        $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
      }
    });

  $('.qty').change(function(){
    qty = $(this).val();
  });

  $('html').on('change', 'select', function(){
    $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
  });

  $('html').click(function(){
    $('.total-price').html((currPrice + byob + upgrade + wine + mimosas) * qty - (currPrice * groupon));
  });

  $('.byob-link').click(function(e){
    e.preventDefault();
    $('.byob-user').slideDown();
  });

  $('.pop').popover()

});

