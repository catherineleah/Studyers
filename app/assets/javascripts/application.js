//= require jquery  
//= require jquery-ui
//= require jquery_ujs  
//= require_self  

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


function exposeImages(ID) {
  $("#upload-class_resource").remove();
  $("#presentation-loader").remove();
  $("#show-embed-form .side-message").show();
  $("#show-embed-form .side-message #get-resource").val(ID);
  $("#show-embed-form .side-message #fetch-resource").click();
}