$( document ).ready(function() {
  $('.attendee-delete').click(function(e){
    var r = confirm("Are you sure you want to delete this?");
    if (r == false) {
        return false;
    }
  });


});