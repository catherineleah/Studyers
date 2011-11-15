/*
	Create a unique id according to timestamp.
*/
function uniqueId() {
    return 'id_' + new Date().getTime();
}

function modifyCanvasAndImageWidth() {
  var newWidth = $("#text-editor").width();
  var canvases = document.getElementsByTagName('canvas');
  for (i = 0; i < canvases.length; i++) {
    canvases[i].width = newWidth;
  }
  var images = $("#text-editor img");
  for (i = 0; i < images.length; i++) {
    images[i].width = newWidth;
  }
}

function buttonsAppend(afterID) {
  return '<div class="dont-save text-after btn" after="'+ afterID +'">+ textarea</div><div class="dont-save draw-after btn" after="'+ afterID +'">+ drawpad</div><div class="dont-save graph-after btn" after="'+ afterID +'">+ graph</div><div class="dont-save wiki-after btn" after="'+ afterID +'">Find on Wikipedia</div>';
}
