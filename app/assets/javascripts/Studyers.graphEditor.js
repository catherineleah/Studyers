function graphEditor(ID, putAfter) {
  this.ID = ID;
  DrawEditor.call(this, ID, putAfter);
  this.containerDiv = document.createElement("div");
  this.containerDiv.className = "graph-container";
  this.containerDiv.id = "graph-container-" + this.ID;
  if (putAfter) {
    $(putAfter).after(this.containerDiv);
    $(this.containerDiv).hide().show("slow");
  }
  else {
    $("#text-editor").append(this.containerDiv);
    $(this.containerDiv).hide().show("slow");
  }
  
  this.graphForm = document.createElement("form");
  this.graphForm.className = "graph-form";
  this.graphForm.id = "graph-form-" + this.ID;
  
  this.containerDiv.appendChild(this.graphForm);
  
  $("#graph-form-" + this.ID).append('<label for="graph-type">Graph type:</label><select name="graph-type" id="graph-type-'+ this.ID +'"><option value="bvg">Vertical Bar</option><option value="bhg">Horizontal Bar</option><option value="p">Pie chart</option><option value="lc">Line chart</option></select>');
  $("#graph-form-" + this.ID).append('<label for="graph-data">Input data:</label><input name="graph-data" id="graph-data-'+ this.ID +'" type="text" />');
  $("#graph-form-" + this.ID).append('<label for="graph-desc">Input labels:</label><input name="graph-desc" id="graph-desc-'+ this.ID +'" type="text" />');
  $("#graph-form-" + this.ID).append('<div class="graphus" id="submit-'+ this.ID +'">submit</div>');
  /*var el = document.getElementById("submit-" + this.ID);
    el.addEventListener("click", this.submit(), false);*/
}

graphEditor.prototype.submit = function() {
  console.log(this.graphForm.id);
  return false;
}

