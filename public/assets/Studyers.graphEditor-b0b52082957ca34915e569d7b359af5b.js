function graphEditor(a,b){this.ID=a,this.containerDiv=document.createElement("div"),this.containerDiv.className="graph-container",this.containerDiv.id="graph-container-"+this.ID,b?($(b).after(this.containerDiv),$(this.containerDiv).hide().show("slow")):($("#text-editor").append(this.containerDiv),$(this.containerDiv).hide().show("slow")),this.graphForm=document.createElement("form"),this.graphForm.className="graph-form dont-save",this.graphForm.id="graph-form-"+this.ID,this.containerDiv.appendChild(this.graphForm),this.graphDiv=document.createElement("div"),this.graphDiv.className="graph-wrapper",this.graphDiv.id="graph-wrapper-"+this.ID,this.containerDiv.appendChild(this.graphDiv),$("#graph-form-"+this.ID).append('<label for="graph-type">Graph type:</label><select name="graph-type" id="graph-type-'+this.ID+'"><option value="bvg">Vertical Bar</option><option value="bhg">Horizontal Bar</option><option value="p">Pie chart</option><option value="lc">Line chart</option></select>'),$("#graph-form-"+this.ID).append('<label for="graph-data">Input data:</label><input name="graph-data" id="graph-data-'+this.ID+'" type="text" />'),$("#graph-form-"+this.ID).append('<label for="graph-desc">Input labels:</label><input name="graph-desc" id="graph-desc-'+this.ID+'" type="text" />'),$("#graph-form-"+this.ID).append('<div class="graphus btn" id="submit-'+this.ID+'">Create chart</div>'),$("#graph-form-"+this.ID).append('<div class="explain-graph">First choose chart type, then on the input field add numerical values in the format: 1,2,3 (no spaces) and in the label field add the corresponding labels in the format: a|b|c (no spaces)</div>');var c=document.getElementById("submit-"+this.ID);c.addEventListener("click",function(){submitGraph(a)},!1),$("#graph-container-"+this.ID).after(buttonsAppend("#graph-container-"+this.ID))}function submitGraph(a){var b=$("#graph-type-"+a).val(),c=$("#graph-data-"+a).val(),d=$("#graph-desc-"+a).val(),e=c.split(","),f=0,g=0;for(i=0;i<e.length;i++)e[i]>f&&(f=e[i]),e[i]<g&&(g=e[i]);var h=new Image;h.id="image-graph-"+a,h.src="http://chart.apis.google.com/chart?chxt=y&chds="+g+","+f+"&chxr=0,"+g+","+f+"&chbh=a&chs=600x350&cht="+b+"&chd=t:"+c+"&chl="+d+"",$("#graph-wrapper-"+a).append(h)}