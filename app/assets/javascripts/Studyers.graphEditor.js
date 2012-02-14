function graphEditor(ID, putAfter) {
  this.ID = ID;
  this.containerDiv = document.createElement("div");
  this.containerDiv.className = "graph-container field-container clear-both";
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
  this.graphForm.className = "graph-form dont-save";
  this.graphForm.id = "graph-form-" + this.ID;
  
  this.containerDiv.appendChild(this.graphForm);
  
  this.graphDiv = document.createElement("div");
  this.graphDiv.className = "graph-wrapper";
  this.graphDiv.id = "graph-wrapper-" + this.ID;
  
  this.containerDiv.appendChild(this.graphDiv);
  
  $("#graph-form-" + this.ID).append('<label for="graph-type">chart type:</label><select name="graph-type" id="graph-type-'+ this.ID +'"><option value="bvg">Vertical Bar</option><option value="bhg">Horizontal Bar</option><option value="p">Pie chart</option><option value="lc">Line chart</option></select><br />');
  $("#graph-form-" + this.ID).append('<label for="graph-data">Input data:</label><input name="graph-data" class="gr-vals" id="graph-data-'+ this.ID +'" type="text" /><br />');
  $(".gr-vals").watermark("values seperated by comma (e.g: 4,5,6)");
  $("#graph-form-" + this.ID).append('<label for="graph-desc">Input labels:</label><input name="graph-desc" class="gr-lbl" id="graph-desc-'+ this.ID +'" type="text" />');
  $(".gr-lbl").watermark("labels seperated by | (e.g: Harry|Barry|Ari)");
  $("#graph-form-" + this.ID).append('<div class="graphus" id="submit-'+ this.ID +'">Create chart</div>');
  
  var submitDiv = document.getElementById("submit-" + this.ID);
  submitDiv.addEventListener('click', function() {submitGraph(ID)}, false)
  
  $("#graph-wrapper-" + this.ID).after(buttonsAppend("#graph-container-" + this.ID, 'charts'));
  $(".add").tooltip('hide');;
}
function submitGraph(ID) {
  var type = $("#graph-type-" + ID).val();
  var data = $("#graph-data-" + ID).val();
  var labels = $("#graph-desc-" + ID).val();
  
  var dataArray = data.split(",");
  var highest = 0;
  var smallest = 0
  for (i = 0; i < dataArray.length; i++) {
    if (dataArray[i] > highest) {
      highest = dataArray[i];
    }
    if (dataArray[i] < smallest) {
      smallest = dataArray[i];
    }
  }

  var graphImage = new Image();
  graphImage.id = "image-graph-" + ID;
  graphImage.src = "http://chart.apis.google.com/chart?chxt=y&chds="+smallest+","+highest+"&chxr=0,"+smallest+","+highest+"&chbh=a&chs=600x350&cht="+type+"&chd=t:"+data+"&chl="+labels+"";
  $("#graph-wrapper-" + ID).append('<div class="graph-remove dont-save">X</div>');
  $("#graph-wrapper-" + ID).append(graphImage);
}
