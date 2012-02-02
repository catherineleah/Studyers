//= require jquery  
//= require jquery-ui
//= require jquery_ujs
//= require jquery.poshytip
//= require jquery.watermark.min
//= require_self  

$(document).ready(function() {
  
  $('.del-lesson, .del-notebook').bind('ajax:success', function() {  
      $(this).parent().parent().parent().hide("slow");  
  });
  
   $(".show-image").click(function() {
     $(this).next(".attached-image").toggle("slow");
   });

  setTimeout(function() {
    $('div.alert-message').fadeOut('slow');
  }, 7000);
      
  $("#show-embed, #share-lesson, #clear").poshytip();
  $(".add").poshytip({alignY: 'bottom'});
  
  $("#wiki-term-input").watermark("Search on Wikipedia");
  $("#lesson_title").watermark("Lesson title");
  $(".home #user_email").watermark("email address");
  $(".home #user_password").watermark("password");
  
});

function exposeImages(ID) {
  $("#upload-class_resource").remove();
  $("#presentation-loader").remove();
  $("#show-embed-form .side-message").show();
  $("#show-embed-form .side-message #get-resource").val(ID);
  $("#show-embed-form .side-message #fetch-resource").click();
}
