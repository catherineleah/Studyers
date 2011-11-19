/*
  @package: Studyers
  @Version: 1.0
  @Description: This class wraps images from teachers presentation into the lesson. 
*/
function classResources(imageSrc, imageIndex){
  // make sure image ID is unique with it's index
  this.ID = uniqueId() + imageIndex;
  this.imageWrapper = document.createElement('div');
  this.imageWrapper.className = "class-resources-image";
  this.imageWrapper.id = "image-wrapper-" + this.ID;
  this.image = document.createElement('img');
  this.image.className = "resource-image";
  this.image.src = imageSrc;
  var imageWidth = $("#text-editor").width()-5;
  this.image.width = imageWidth;
  this.image.id = "resource-image-" + this.ID;
  
  this.imageWrapper.appendChild(this.image);
  $("#text-editor").append(this.imageWrapper);
}

classResources.prototype.showControls = function() {
  $("#resource-image-" + this.ID).after(buttonsAppend("#image-wrapper-" + this.ID));
}

$(document).ready(function() {
  $("#fetch-resource").click(function(e){
    e.preventDefault();
    if ($("#get-resource") != null) {
      var rId = $("#get-resource").val();
      $(".presentation-embed").load("/class_resources/" + rId + " #resource-images", function(response, status, xhr) {
        if (status == "error" || $(".presentation-embed img").length == 0 ) {
          $(".presentation-embed").html("Can't find selected resource");
          return;
        }
        $(this).parent().find(".block-message").hide();
        $(".presentation-embed").prepend('<div class="side-message block-message info">To embed the presentation into the lesson <br /><a href="#" id="photocopy" class="btn">Click here</a><br /> or click on each slide to embed seperately</div>');
      });
    }
  });
  $("#upload-resource").click(function(e) {
    e.preventDefault();
    $(this).parent().parent().hide();
    $(".presentation-embed").load("/class_resources/new #upload-class_resource", function(response, status, xhr){});
  });
  
  $("#continue-upload").live('click', function(e) {
    e.preventDefault();
    var postUrl = $(this).parent().attr("action");
    
    $.ajax({
      type: "POST",
      url: postUrl,
      data: {
        edit: "true"
      },
      success: function(data) {
        
        var resourceId = $(data).find("#resource_id").val();
        $("#upload-class_resource").after('<iframe id="presentation-loader" class="side-message block-message info" src="/class_resources/'+resourceId+'/edit" frameborder="0"></iframe>');
      }
    });
  });
  
  /*
    All slides
  */
  $("#photocopy").live('click', function(e){
    e.preventDefault();
    $("#text-editor").removeClass("minified");
    $(".presentation-embed #resource-images img").each(function(index){
      var imageSrc = $(this).attr('src');
      // index is passed to make sure uninque id for image.
      var classImage = new classResources(imageSrc, index);
      classImage.showControls();
    });
    // Close the sidebar
    $("#side-resources").hide("slide", {direction: "right"});
    modifyCanvasAndImageWidth();
  });
  /*
    One slide
  */
  $(".one-slide").live('click', function(e) {
    e.preventDefault();
    $("#text-editor").removeClass("minified");
    var imageSrc = $(this).find("img").attr('src');
    var classImage = new classResources(imageSrc, 0);
    classImage.showControls();
  });
});