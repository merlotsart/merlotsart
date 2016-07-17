$( document ).ready(function() {
  $('form').on('change', '.promo-code', function() {
    var promoCode = $(this).val();
    var subtotal = $('#order_total').val();

    // Need a subtotal but trying to pull via jquery is being a pain (security
    // warning).
    //
    // What needs to happen:
    //
    // 1. We need to check the promo code
    // 2. We need to update the discount amount
    // 3. we need to update the subtotal
    //
    // If the subtotal update is done in JS, we need to know the discount type
    // and amount
    //
    // What if the subtotal was a hidden form element?

    var request = $.ajax({
      url: '/promos',
      method: 'GET',
      data: {promoCode: promoCode, subtotal: subtotal }
    })
    console.log(request);
    request.success(function(response) {
      if (response.valid) {

        // NEEDS REFACTOR! No order math in javascript!
        var oldTotalFind = $('.total-price-summary').html();
        var oldTotal = oldTotalFind

        $('.total-price-new').html(response.total);
        $('.total-price-row').html(response.total);

        // $('.total-price-new').html(accounting.formatMoney(parseInt(oldTotal) - (parseInt(oldTotal) * (parseInt(response.discount)/100))));
        // $('.total-price-row').html(accounting.formatMoney(parseInt(oldTotal) - (parseInt(oldTotal) * (parseInt(response.discount)/100))));

        $('.promo-result').html("<label class='promo-success'>Promo Code Applied</label>");
        $('.promo-result-row').html("<th>Promo Code</th><td>" + response.discount + "</td>");
        // END NEEDS REFACTOR! No order math in javascript!

      } else {
        $('.promo-result').html("<label class='promo-fail'>Promo Code Not Valid</label>");
      }
    });
  });
});


