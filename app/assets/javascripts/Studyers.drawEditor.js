
/*
  The class for the drawing tool.
*/
function DrawEditor(ID, putAfter) {
  this.ID = ID;
  this.tool_select;
  // Create container and append it to text editor.
  this.containerDiv = document.createElement("div");
  this.containerDiv.className = "canvas-container field-container clear-both";
  this.containerDiv.id = "canvas-container-" + this.ID;
  if (putAfter) {
    $(putAfter).after(this.containerDiv);
    $(this.containerDiv).hide().show("slow");
  }
	else {
		$("#text-editor").append(this.containerDiv);
		$(this.containerDiv).hide().show("slow");
	}
	var canvasWidth = $("#text-editor").width() - 10;
	//Create first canvas
	this.canvaso = document.createElement("canvas");
	this.canvaso.id = "imageView-" + this.ID;
	this.canvaso.className = "canvas canvas-draw imageView"
	this.canvaso.width = canvasWidth;
	this.canvaso.height = "400";
	this.containerDiv.appendChild(this.canvaso);
	this.contexto = this.canvaso.getContext('2d');
	// Create 2nd canvas (temp)
	this.canvas = document.createElement("canvas");
	this.canvas.id = "imageTemp-" +this.ID;
	this.canvas.className = "canvas canvas-draw-temp imageTemp";
	this.canvas.width = canvasWidth;
	this.canvas.height = "400";
	this.containerDiv.appendChild(this.canvas);
	this.context = this.canvas.getContext('2d');
	//Attach controls
	$("#canvas-container-" + this.ID).append('<div class="dtools"><div class="dtool dtool-'+ this.ID +'" id="text" title="Add text to canvas">Text</div><div class="dtool dtool-'+ this.ID +'" id="pencil" title="Pencil draw">p</div><div class="dtool dtool-'+ this.ID +'" id="line" title="Line draw">l</div><div class="dtool dtool-'+ this.ID +'" id="rect" title="Rectangle draw">r</div><div class="dtool dtool-'+ this.ID +'" id="circle" title="Circle draw">c</div><div class="dtool dtool-'+ this.ID +'" id="clear" title="Clear this canvas">cls</div></div>');
	$("#canvas-container-" + this.ID).append(buttonsAppend("#canvas-container-" + this.ID, 'drawpad'));
	$('.dtool').tooltip('hide');;
	var canvas = this.canvas;
	var context = this.context;
	var canvaso = this.canvaso
	var contexto = this.contexto;

  // The active tool instance.
  var tool;
  var tool_default = 'pencil';

  this.drawInit = function(ID){
			var ID = ID;
      // Find the canvas element.
      canvaso = document.getElementById('imageView-' + ID);
      if (!canvaso) {
          alert('Error: I cannot find the canvas element!');
          return;
      }

      if (!canvaso.getContext) {
          alert('Error: no canvas.getContext!');
          return;
      }

      // Get the 2D canvas context.
      contexto = canvaso.getContext('2d');
      if (!contexto) {
          alert('Error: failed to getContext!');
          return;
      }

      // Add the temporary canvas.
      var container = 'canvas-container-' + ID;
      canvas = document.getElementById('imageTemp-' + ID);
      if (!canvas) {
          alert('Error: I cannot create a new canvas element!');
          return;
      }

      context = canvas.getContext('2d');

      // Get the tool select input.
      var tool_select = document.getElementsByClassName('dtool-' + ID );
      //console.log(tool_select);
      if (!tool_select) {
          alert('Error: failed to get the dtool element!');
          return;
      }

      for (var i = 0; i < tool_select.length; i++) {
          //console.log(i);
          tool_select[i].addEventListener('click', ev_tool_change, false);
      }

      // Activate the default tool.
      if (tools[tool_default]) {
          tool = new tools[tool_default]();
          tool_select.value = tool_default;
      }

      // Attach the mousedown, mousemove and mouseup event listeners.
      canvas.addEventListener('mousedown', ev_canvas, false);
      canvas.addEventListener('mousemove', ev_canvas, false);
      canvas.addEventListener('mouseup', ev_canvas, false);
  }

  //color handling:
  // Colors:
  var colorBlue = "#cb3594";
  var colorGreen = "#659b41";
  var colorYellow = "#ffcf33";
  var colorBrown = "#986928";
  var colorBlack = "#333333";

  //Default color.
  var curColor = colorBlack;
  // change colors
  $('.color').click(function(){
      var color = $(this).attr("id");
      switch (color) {
          case "colorBrown":
              curColor = colorBrown;
              break;
          case "colorYellow":
              curColor = colorYellow;
              break;
          case "colorGreen":
              curColor = colorGreen;
              break;
          case "colorBlack":
              curColor = colorBlack;
              break;
          case "colorBlue":
              curColor = colorBlue;
              break;
      }
  });

  //context.lineWidth
  // Width 
  var smallWidth = 1;
  var mediumWidth = 4;
  var largeWidth = 8;

  // Default width
  var curWidth = smallWidth;

  // Width picker
  $('.width').click(function(){
      var toolWidth = $(this).attr("id");
      switch (toolWidth) {
          case "smallWidth":
              curWidth = smallWidth;
              break;
          case "mediumWidth":
              curWidth = mediumWidth;
              break;
          case "largeWidth":
              curWidth = largeWidth;
              break;
      }
  });

  // The general-purpose event handler. This function just determines the mouse 
  // position relative to the canvas element.
  function ev_canvas(ev){
      if (ev.offsetX || ev.offsetX == 0) { // Opera
          ev._x = ev.offsetX;
          ev._y = ev.offsetY;
      }
      else 
         if (ev.layerX || ev.layerX == 0) { // Firefox
             ev._x = ev.layerX;
             ev._y = ev.layerY;
         }

      // Call the event handler of the tool.
      var func = tool[ev.type];
      if (func) {
          func(ev);
      }
  }

  // The event handler for any changes made to the tool selector.
  function ev_tool_change(ev){
      //if (tools[this.value]) {
      tool = new tools[this.id]();
      //}
  }

  // This function draws the #imageTemp canvas on top of #imageView, after which 
  // #imageTemp is cleared. This function is called each time when the user 
  // completes a drawing operation.
  function img_update(){
      contexto.drawImage(canvas, 0, 0);
      context.clearRect(0, 0, canvas.width, canvas.height);
  }

  // This object holds the implementation of each drawing tool.
  var tools = {};

  // The drawing pencil.
  tools.pencil = function(){
      var tool = this;
      this.started = false;

      // This is called when you start holding down the mouse button.
      // This starts the pencil drawing.
      this.mousedown = function(ev){
          context.beginPath();
          context.moveTo(ev._x, ev._y);
          tool.started = true;
      };

      // This function is called every time you move the mouse. Obviously, it only 
      // draws if the tool.started state is set to true (when you are holding down 
      // the mouse button).
      this.mousemove = function(ev){
          if (tool.started) {
              context.lineTo(ev._x, ev._y);

              /**
               * @TODO: workaround  linecap
               */
              context.lineCap = "round";

              context.strokeStyle = curColor;
              context.lineWidth = curWidth;
              context.stroke();
          }
      };

      // This is called when you release the mouse button.
      this.mouseup = function(ev){
          if (tool.started) {
              tool.mousemove(ev);
              tool.started = false;
              img_update();
          }
      };
  };

  // The rectangle tool.
  tools.rect = function(){
      var tool = this;
      this.started = false;

      this.mousedown = function(ev){
          tool.started = true;
          tool.x0 = ev._x;
          tool.y0 = ev._y;
      };

      this.mousemove = function(ev){
          if (!tool.started) {
              return;
          }

          var x = Math.min(ev._x, tool.x0), y = Math.min(ev._y, tool.y0), w = Math.abs(ev._x - tool.x0), h = Math.abs(ev._y - tool.y0);

          context.clearRect(0, 0, canvas.width, canvas.height);

          if (!w || !h) {
              return;
          }

          context.strokeStyle = curColor;
          context.lineWidth = curWidth;
          context.strokeRect(x, y, w, h);
      };

      this.mouseup = function(ev){
          if (tool.started) {
              tool.mousemove(ev);
              tool.started = false;
              img_update();
          }
      };
  };

  // The circle tool.
  tools.circle = function(){
      var tool = this;
      this.started = false;

      this.mousedown = function(ev){
          tool.started = true;
          tool.x0 = ev._x;
          tool.y0 = ev._y;
      };

      this.mousemove = function(ev){
          if (!tool.started) {
              return;
          }

          var x = Math.min(ev._x, tool.x0), y = Math.min(ev._y, tool.y0), w = Math.abs(ev._x - tool.x0), h = Math.abs(ev._y - tool.y0);

          context.clearRect(0, 0, canvas.width, canvas.height);

          if (!w || !h) {
              return;
          }

          context.strokeStyle = curColor;
          context.lineWidth = curWidth;
          context.beginPath();
          context.arc(x, y, w, 0, Math.PI * 2, true);
          context.closePath();
          context.stroke();
      };

      this.mouseup = function(ev){
          if (tool.started) {
              tool.mousemove(ev);
              tool.started = false;
              img_update();
          }
      };
  };

  // The clear tool
	tools.clear = function() {
		var tool = this;
		this.started = true;
		contexto.clearRect(0, 0, canvas.width, canvas.height);
		context.clearRect(0, 0, canvas.width, canvas.height);
		tool.started = false;
		img_update();
	}
	
	tools.text = function() {
		var tool = this;
		this.started = false;
		this.mousedown = function(ev) {
			var text = prompt("Enter text to add to draw", "Enter text to add to draw")
			context.beginPath();
			context.moveTo(ev._x, ev._y);
			tool.started = true;
			if (text)
				context.strokeText(text, ev._x, ev._y); 
			// need to update here as there is no mouse move.
			img_update();
		}
		
		this.mouseup = function(ev) {
			if (tool.started) {
				tool.started = false;
				img_update();
			}
		}
		
	}

  // The line tool.
  tools.line = function(){
      var tool = this;
      this.started = false;

      this.mousedown = function(ev){
          tool.started = true;
          tool.x0 = ev._x;
          tool.y0 = ev._y;
      };

      this.mousemove = function(ev){
          if (!tool.started) {
              return;
          }

          context.clearRect(0, 0, canvas.width, canvas.height);

          context.beginPath();
          context.strokeStyle = curColor;
          context.lineWidth = curWidth;
          context.moveTo(tool.x0, tool.y0);
          context.lineTo(ev._x, ev._y);
          context.stroke();
          context.closePath();
      };

      this.mouseup = function(ev){
          if (tool.started) {
              tool.mousemove(ev);
              tool.started = false;
              img_update();
          }
      };
  };
}
