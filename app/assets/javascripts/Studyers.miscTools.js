/*
 * @package: Studyers core JS
 * Misc. tools that serve lessons classes
 */

/*
 * Create a unique id according to timestamp.
 */
function uniqueId() {
    return 'id_' + new Date().getTime();
}

function modifyCanvasAndImageWidth() {
  var newWidth = $("#text-editor").width() - 14;

  var images = $("#text-editor img.resource-image");
  for (i = 0; i < images.length; i++) {
    images[i].width = newWidth;
  }
}

function buttonsAppend(afterID, type) {
  return '<div class="add dont-save text-after btn info" title="Add another text area" after="'+ afterID +'">+ textarea</div><div title="Add another draw pad" class="add dont-save draw-after btn info" after="'+ afterID +'">+ drawpad</div><div title="Add another graph" class="add dont-save graph-after btn info" after="'+ afterID +'">+ graph</div><div title="Remove this '+ type +'" class="add dont-save remove-object btn" after="'+ afterID +'">X</div>';
}
