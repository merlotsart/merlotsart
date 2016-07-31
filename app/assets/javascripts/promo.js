$( document ).ready(function() {
  $('form').on('change', '.promo-code', function() {
    var promoCode = $(this).val();
    var subtotal = $('#order_total').val();

    var request = $.ajax({
      url: '/promos',
      method: 'GET',
      data: {promoCode: promoCode, subtotal: subtotal }
    })
    console.log(request);
    request.success(function(response) {
      if (response.valid) {

        var oldTotalFind = $('.total-price-summary').html();
        var oldTotal = oldTotalFind

        $('.total-price-new').html(response.total);
        $('.total-price-row').html(response.total);

        $('.promo-result').html("<label class='promo-success'>Promo Code Applied</label>");
        $('.promo-result-row').html("<th>Promo Code</th><td>" + response.discount + "</td>");

      } else {
        $('.promo-result').html("<label class='promo-fail'>Promo Code Not Valid</label>");
      }
    });
  });
});


