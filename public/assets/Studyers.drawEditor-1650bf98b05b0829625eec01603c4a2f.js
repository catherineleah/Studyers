/*
  The class for the drawing tool.
*/
function DrawEditor(a,b){function t(a){if(a.layerX||a.layerX==0)a._x=a.layerX,a._y=a.layerY;else if(a.offsetX||a.offsetX==0)a._x=a.offsetX,a._y=a.offsetY;var b=h[a.type];b&&b(a)}function u(a){h=new w[this.id]}function v(){g.drawImage(d,0,0),e.clearRect(0,0,d.width,d.height)}this.ID=a,this.tool_select,this.containerDiv=document.createElement("div"),this.containerDiv.className="canvas-container",this.containerDiv.id="canvas-container-"+this.ID,b?($(b).after(this.containerDiv),$(this.containerDiv).hide().show("slow")):($("#text-editor").append(this.containerDiv),$(this.containerDiv).hide().show("slow"));var c=$("#text-editor").width();this.canvaso=document.createElement("canvas"),this.canvaso.id="imageView-"+this.ID,this.canvaso.className="canvas canvas-draw imageView",this.canvaso.width=c,this.canvaso.height="400",this.containerDiv.appendChild(this.canvaso),this.contexto=this.canvaso.getContext("2d"),this.canvas=document.createElement("canvas"),this.canvas.id="imageTemp-"+this.ID,this.canvas.className="canvas canvas-draw-temp imageTemp",this.canvas.width=c,this.canvas.height="400",this.containerDiv.appendChild(this.canvas),this.context=this.canvas.getContext("2d"),$("#canvas-container-"+this.ID).append('<div class="dtools"><div class="dtool dtool-'+this.ID+'" id="text" title="Pencil tool">TEXT</div><div class="dtool dtool-'+this.ID+'" id="pencil" title="Pencil tool">p</div><div class="dtool dtool-'+this.ID+'" id="line" title="Line tool">l</div><div class="dtool dtool-'+this.ID+'" id="rect" title="Rectangle tool">r</div><div class="dtool dtool-'+this.ID+'" id="circle" title="Circle tool">c</div><div class="dtool dtool-'+this.ID+'" id="clear" title="Clear canvas">cls</div></div>'),$("#canvas-container-"+this.ID).append(buttonsAppend("#canvas-container-"+this.ID));var d=this.canvas,e=this.context,f=this.canvaso,g=this.contexto,h,i="pencil";this.drawInit=function(a){var a=a;f=document.getElementById("imageView-"+a);if(!f){alert("Error: I cannot find the canvas element!");return}if(!f.getContext){alert("Error: no canvas.getContext!");return}g=f.getContext("2d");if(!g){alert("Error: failed to getContext!");return}var b="canvas-container-"+a;d=document.getElementById("imageTemp-"+a);if(!d){alert("Error: I cannot create a new canvas element!");return}e=d.getContext("2d");var c=document.getElementsByClassName("dtool-"+a);if(!c){alert("Error: failed to get the dtool element!");return}for(var j=0;j<c.length;j++)c[j].addEventListener("click",u,!1);w[i]&&(h=new w[i],c.value=i),d.addEventListener("mousedown",t,!1),d.addEventListener("mousemove",t,!1),d.addEventListener("mouseup",t,!1)};var j="#cb3594",k="#659b41",l="#ffcf33",m="#986928",n="#333333",o=n;$(".color").click(function(){var a=$(this).attr("id");switch(a){case"colorBrown":o=m;break;case"colorYellow":o=l;break;case"colorGreen":o=k;break;case"colorBlack":o=n;break;case"colorBlue":o=j}});var p=1,q=4,r=8,s=p;$(".width").click(function(){var a=$(this).attr("id");switch(a){case"smallWidth":s=p;break;case"mediumWidth":s=q;break;case"largeWidth":s=r}});var w={};w.pencil=function(){var a=this;this.started=!1,this.mousedown=function(b){e.beginPath(),e.moveTo(b._x,b._y),a.started=!0},this.mousemove=function(b){a.started&&(e.lineTo(b._x,b._y),e.lineCap="round",e.strokeStyle=o,e.lineWidth=s,e.stroke())},this.mouseup=function(b){a.started&&(a.mousemove(b),a.started=!1,v())}},w.rect=function(){var a=this;this.started=!1,this.mousedown=function(b){a.started=!0,a.x0=b._x,a.y0=b._y},this.mousemove=function(b){if(!a.started)return;var c=Math.min(b._x,a.x0),f=Math.min(b._y,a.y0),g=Math.abs(b._x-a.x0),h=Math.abs(b._y-a.y0);e.clearRect(0,0,d.width,d.height);if(!g||!h)return;e.strokeStyle=o,e.lineWidth=s,e.strokeRect(c,f,g,h)},this.mouseup=function(b){a.started&&(a.mousemove(b),a.started=!1,v())}},w.circle=function(){var a=this;this.started=!1,this.mousedown=function(b){a.started=!0,a.x0=b._x,a.y0=b._y},this.mousemove=function(b){if(!a.started)return;var c=Math.min(b._x,a.x0),f=Math.min(b._y,a.y0),g=Math.abs(b._x-a.x0),h=Math.abs(b._y-a.y0);e.clearRect(0,0,d.width,d.height);if(!g||!h)return;e.strokeStyle=o,e.lineWidth=s,e.beginPath(),e.arc(c,f,g,0,Math.PI*2,!0),e.closePath(),e.stroke()},this.mouseup=function(b){a.started&&(a.mousemove(b),a.started=!1,v())}},w.clear=function(){var a=this;this.started=!0,g.clearRect(0,0,d.width,d.height),e.clearRect(0,0,d.width,d.height),a.started=!1,v()},w.text=function(){var a=this;this.started=!1,this.mousedown=function(b){var c=prompt("Enter text to add to draw","Enter text to add to draw");e.beginPath(),e.moveTo(b._x,b._y),a.started=!0,c&&e.strokeText(c,b._x,b._y),v()},this.mouseup=function(b){a.started&&(a.started=!1,v())}},w.line=function(){var a=this;this.started=!1,this.mousedown=function(b){a.started=!0,a.x0=b._x,a.y0=b._y},this.mousemove=function(b){if(!a.started)return;e.clearRect(0,0,d.width,d.height),e.beginPath(),e.strokeStyle=o,e.lineWidth=s,e.moveTo(a.x0,a.y0),e.lineTo(b._x,b._y),e.stroke(),e.closePath()},this.mouseup=function(b){a.started&&(a.mousemove(b),a.started=!1,v())}}}