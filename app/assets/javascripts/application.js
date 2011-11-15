//= require jquery  
//= require jquery-ui
//= require jquery_ujs  
//= require_self  
//= require bootstrap-dropdown
//= require jquery.cycle

$(document).ready(function() {
  
  $('.delete-lesson, .delete-notebook').bind('ajax:success', function() {  
      $(this).parent().hide("slow");  
  });
  
   $(".show-image").click(function() {
     $(this).next(".attached-image").toggle("slow");
   });

  
  setTimeout(function() {
      $('div.alert-message').fadeOut('slow');
    }, 7000);
      

});