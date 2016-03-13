$(window).ready(function(){
  $('#private_event_date').datepicker();
  $('#private_event_start_time').clockpicker({
    donetext: 'Use Time',
    twelvehour: true
  });
  $('#private_event_end_time').clockpicker({
    donetext: 'Use Time',
    twelvehour: true
  });
});
