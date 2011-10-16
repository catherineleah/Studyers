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
  this.image.className = "resource-image span12";
  this.image.src = imageSrc;
/*  this.image.width = "500";*/
  this.image.id = "resource-image-" + this.ID;
  
  this.imageWrapper.appendChild(this.image);
  $("#text-editor").append(this.imageWrapper);
}

classResources.prototype.showControls = function() {
  $("#resource-image-" + this.ID).after('<div class="text-after btn" after="#image-wrapper-'+ this.ID +'">+ textarea</div><div class="draw-after btn" after="#image-wrapper-'+ this.ID +'">+ drawpad</div>');
}

$(document).ready(function() {
  $("#fetch-resource").click(function(e){
    e.preventDefault();
    if ($("#get-resource") != null) {
      var rId = $("#get-resource").val();
      $(".resources").load("/class_resources/" + rId + " #resource-images", function(response, status, xhr) {
        if (status == "error") {
          $(".resources").html("Can't find selected resource");
          return;
        }
        $(".resources").prepend('<div class="alert-message block-message info"><a href="#" id="photocopy">Copy presentation to the lesson</a></div>');
      });
    }
  });
  /*
    All slides
  */
  $("#photocopy").live('click', function(e){
    e.preventDefault();
    $(".resources #resource-images img").each(function(index){
      var imageSrc = $(this).attr('src');
      // index is passed to make sure uninque id for image.
      var classImage = new classResources(imageSrc, index);
      classImage.showControls();
    });
  });
  /*
    One slide
  */
  $(".one-slide").live('click', function(e) {
    e.preventDefault();
    var imageSrc = $(this).find("img").attr('src');
    var classImage = new classResources(imageSrc, 0);
    classImage.showControls();
  });
});