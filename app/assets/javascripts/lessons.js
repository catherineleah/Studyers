//= require Studyers.textEditor
//= require Studyers.drawEditor
//= require Studyers.classResources

/*
	Editor V2.0 
	@Author: Shlomi Zadok.
	@project: Studyers
*/


/*
	Create a unique id according to timestamp.
*/
function uniqueId() {
    return 'id_' + new Date().getTime();
}


$(document).ready(function() {
	var lessonText = $("#lesson_body").val();
  //console.log(lessonText);
  $("#lesson_body").hide();
  $("#lesson_body").after('<div id="text-editor"></div>');
	var text = new TextEditor();
	text.showControls();
	if (lessonText)
		text.savedText(lessonText);
	
	
	$("#add-text").click(function() {
  	var text = new TextEditor();
		text.showControls();
  });

	$(".text-after").live('click', function() {
		var putAfter = $(this).attr('after');
  	var text = new TextEditor(putAfter);
		text.showControls();
  });

	$(".draw-after").live('click', function() {
		var putAfter = $(this).attr('after');
		var ID = uniqueId();
  	var draw = new DrawEditor(ID, putAfter);
		draw.drawInit(ID);
  });

	$("#add-draw").click(function() {
		var ID = uniqueId();
		var draw = new DrawEditor(ID);
		draw.drawInit(ID);
	});

  $("#lesson_submit").click(function(){
		// Cleanup tools
	  $("#text-editor .buttons, #text-editor .dtool, #text-editor .text-after, #text-editor .draw-after").remove();
		// create images from canvases
		var canvases = document.getElementsByClassName('imageView');
		for (var i = 0; i < canvases.length; i++) {
			var data = canvases[i].toDataURL();
			var container = canvases[i].parentNode;
			
			var img = document.createElement('img');
			img.src = data;
			container.insertBefore(img);
		}
		$(".canvas-container canvas").remove();
		$(".canvas-container img").addClass("SavedImage")
		$(".text").removeClass().addClass('SavedText');
    var textSave = $("#text-editor").html();
		//console.log(textSave);
    $("#lesson_body").val(textSave);
    
    if (!$("#lesson_title").val()){
			var today = new Date();
			$("#lesson_title").val(today + "- auto title");
    }
  });
});