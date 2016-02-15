$( document ).ready(function() {
  $('form').on('change', '.promo-code', function() {
    var promoCode = $(this).val();
    var request = $.ajax({
      url: '/promos',
      method: 'GET',
      data: {promoCode: promoCode }
    })
    request.success(function(response) {
      if (response.valid) {
        var oldTotalFind = $('.total-price-summary').html();
        var oldTotal = oldTotalFind
        $('.total-price-new').html(accounting.formatMoney(parseInt(oldTotal) - (parseInt(oldTotal) * (parseInt(response.discount)/100))));
        $('.total-price-row').html(accounting.formatMoney(parseInt(oldTotal) - (parseInt(oldTotal) * (parseInt(response.discount)/100))));
        $('.promo-result').html("<label class='promo-success'>Promo Code Applied</label>");
        $('.promo-result-row').html("<th>Promo Code</th><td>" + response.discount + "%</td>");
      } else {
        $('.promo-result').html("<label class='promo-fail'>Promo Code Not Valid</label>");
      }
    });
  });
});