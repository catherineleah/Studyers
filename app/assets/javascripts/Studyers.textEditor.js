/*
 * Class for the wysiwyg editor
 * Appends contenteditable div to text editor.
 */
function TextEditor(putAfter) {
  this.ID = uniqueId();
  this.textWrapper = document.createElement("div");
  this.textWrapper.className = "text-wrapper";
  this.textWrapper.id = "wrapper-" + this.ID;
  this.textDiv = document.createElement("div");
  this.textDiv.contentEditable="true";
    
  this.textDiv.className="text text_" + this.ID;
  this.textDiv.id = "text-" + this.ID;
  this.textWrapper.appendChild(this.textDiv);
  if (putAfter) {
    $(putAfter).after(this.textWrapper);
    $(this.textWrapper).hide().show("slow");
  }
  else {
    $("#text-editor").append(this.textWrapper);
    $(this.textWrapper).hide().show("slow");
  }  
}

/*
  append the buttons into the text
*/
TextEditor.prototype.showControls = function(){
  $("#text-" + this.ID).before('<div class="editor-buttons buttons" id="buttons-'+this.ID+'"><input id="bold" class="edit-buttons" value="B" type="button" /><input id="italic" class="edit-buttons" value="I" type="button" /><input id="underline" class="edit-buttons" value="U" type="button" /><input id="hilitecolor" class="edit-buttons" attribute="yellow" value="hilite yellow" type="button" /><input id="hilitecolor" class="edit-buttons" attribute="#659b41" value="hilite green" type="button" /><input id="insertunorderedlist" class="edit-buttons" value="List" type="button" /><input id="insertorderedlist" class="edit-buttons" value="Numbered List" type="button" /><input id="increasefontsize" class="edit-buttons" value="A+" type="button"  /><input id="decreasefontsize" class="edit-buttons" value="A-" type="button"  /></div>');
  $("#text-" + this.ID).after(buttonsAppend("#wrapper-" + this.ID));
  /*
  */
  $('#buttons-' + this.ID + ' .edit-buttons').click(function() {
    $("#text-" + this.ID).focus();
    var command = $(this).attr('id');
    var Attribute = $(this).attr('attribute') ? $(this).attr('attribute') : null;  
    document.execCommand(command,false,Attribute);
  });
}
/*
  For editing, append edited text into first instance of the TextEditor.
*/
TextEditor.prototype.savedText = function(savedText) {
  $("#text-" + this.ID).append(savedText);
}
