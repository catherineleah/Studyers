// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function( $ ){
  $.fn.studyEditor = function() {
		var lessonText = $("#lesson_body").val();
		//console.log(lessonText);
		$("#lesson_body").hide();
		$("#lesson_body").after('<div id="text-editor" contentEditable="true">'+lessonText+'</div>');

    $("#lesson_submit").click(function(){
	    var oCanvas = document.getElementById("imageView");
  	  $("#lesson_attachment64").val(oCanvas.toDataURL());
			
			var textSave = $("#text-editor").html();
			$("#lesson_body").val(textSave);
				
  	});
};
})( jQuery );


// Text editor buttons
$(document).ready(function() { 
	$('.edit-buttons').click(function() {
		var command = $(this).attr('id');
		var Attribute = $(this).attr('attribute') ? $(this).attr('attribute') : null;  
		document.execCommand(command,false,Attribute);
	});
});