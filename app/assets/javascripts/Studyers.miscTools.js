/*
 * @package: Studyers core JS
 * Misc. tools that serve lessons classes
 */
/*
	Create a unique id according to timestamp.
*/
function uniqueId() {
    return 'id_' + new Date().getTime();
}

function modifyCanvasAndImageWidth() {
  var newWidth = $("#text-editor").width();
  /*bug with changing canvases width - it deletes drawn images*/
  /*var canvases = document.getElementsByTagName('canvas');
    for (i = 0; i < canvases.length; i++) {
      canvases[i].width = newWidth;
    }*/
  var images = $("#text-editor img.resource-image");
  for (i = 0; i < images.length; i++) {
    images[i].width = newWidth;
  }
}

function buttonsAppend(afterID, type) {
  return '<div class="add dont-save text-after btn info" after="'+ afterID +'">+ textarea</div><div class="add dont-save draw-after btn info" after="'+ afterID +'">+ drawpad</div><div class="add dont-save graph-after btn info" after="'+ afterID +'">+ graph</div><div class="add dont-save remove-object btn" after="'+ afterID +'">- remove this '+ type +'</div>';
}
