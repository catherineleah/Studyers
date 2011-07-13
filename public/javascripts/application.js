// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function( $ ){
  $.fn.studyEditor = function() {
    var lessonText = $("#lesson_body").val();
    //console.log(lessonText);
    $("#lesson_body").hide();
    $("#lesson_body").after('<div id="text-editor" contentEditable="true">'+lessonText+'</div>');

    $("#lesson_submit").click(function(){
      /*
        Due to cross domain on s3 can't save as attachment.. :(
        var oCanvas = document.getElementById("imageView");
        $("#lesson_attachment64").val(oCanvas.toDataURL()); 
       */
     /**
      * Need to think of a better way to save the drafted image
       var oCanvas = document.getElementById("imageView");
       var img_dataurl = oCanvas.toDataURL();
       var img = document.createElement('img');
       img.src = oCanvas.toDataURL();
       img.width="250";
       img.align="left";
       //console.log(img);
       $("#text-editor").append(img);
     */
			
      var textSave = $("#text-editor").html();
      $("#lesson_body").val(textSave);
      
      if (!$("#lesson_title").val()){
	var today = new Date();
	$("#lesson_title").val(today + "(auto title)");
      } 				
    });
};
})( jQuery );


// Text editor buttons
$(document).ready(function() {

        $(".show-image").click(function() {
          $(this).next(".attached-image").toggle("slow");
        });

        if ($("#home-wrapper #cycle")) {
          $("#home-wrapper #cycle").cycle({
            fx: 'fade',
            timeout: 6000, // milliseconds between slide transitions
            pause: 1,
            cleartype: 1,
            cleartypeNoBg: 1
          });
        }
	$('.edit-buttons').click(function() {
		var command = $(this).attr('id');
		var Attribute = $(this).attr('attribute') ? $(this).attr('attribute') : null;  
		document.execCommand(command,false,Attribute);
	});
	
	$("#copy-image").click(function() {
		var oCanvas = document.getElementById("imageView");
                var img_dataurl = oCanvas.toDataURL();
		var img = document.createElement('img'); 
		img.src = oCanvas.toDataURL();
		img.width="250";
                img.align="left";
		//console.log(img);
		$("#text-editor").append(img);
	});

        $(".delete-notebook a, .new-notebook a").poshytip({
            className: 'tip-twitter',
            showTimeout: 1,
            alignTo: 'target',
            alignX: 'left',
            alignY: 'center',
            offsetX: 5,
            allowTipHover: false,
            fade: false,
            slide: false
        });

        $(".edit-notebook a").poshytip({
          className: 'tip-twitter',
          showTimeout: 1,
          alignTo: 'target',
          alignX: 'right',
          alignY: 'center',
          offsetX: 5,
          allowTipHover: false,
          fade: false,
          slide: false
        });

        $(".edit-lesson a, .delete-lesson a").poshytip({
          className: 'tip-twitter',
          showTimeout: 1,
          alignTo: 'target',
          alignX: 'center',
          alignY: 'bottom',
          offsetX: 0,
          offsetY: 5,
          allowTipHover: false,
          fade: false,
          slide: false
        });


        setTimeout(function() {
              $('.notice').fadeOut('slow');
        }, 5000);

});
