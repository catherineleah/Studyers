/*
  @package: Studyers
  @Version: 1.0
  @Description: This class wraps images from teachers presentation into the lesson. 
*/
function classResources(a,b){this.ID=uniqueId()+b,this.imageWrapper=document.createElement("div"),this.imageWrapper.className="class-resources-image",this.imageWrapper.id="image-wrapper-"+this.ID,this.image=document.createElement("img"),this.image.className="resource-image",this.image.src=a;var c=$("#text-editor").width()-5;this.image.width=c,this.image.id="resource-image-"+this.ID,this.imageWrapper.appendChild(this.image),$("#text-editor").append(this.imageWrapper)}classResources.prototype.showControls=function(){$("#resource-image-"+this.ID).after(buttonsAppend("#image-wrapper-"+this.ID))},$(document).ready(function(){$("#fetch-resource").click(function(a){a.preventDefault();if($("#get-resource")!=null){var b=$("#get-resource").val();$(".presentation-embed").load("/class_resources/"+b+" #resource-images",function(a,b,c){if(b=="error"||$(".presentation-embed img").length==0){$(".presentation-embed").html("Can't find selected resource");return}$(".presentation-embed").prepend('<div class="side-message block-message info">To embed the presentation into the lesson <br /><a href="#" id="photocopy" class="btn">Click here</a><br /> or click on each slide to embed seperately</div>')})}}),$("#upload-resource").click(function(a){a.preventDefault(),$(".presentation-embed").load("/class_resources/new #upload-class_resource",function(a,b,c){})}),$("#photocopy").live("click",function(a){a.preventDefault(),$("#text-editor").removeClass("minified"),$(".presentation-embed #resource-images img").each(function(a){var b=$(this).attr("src"),c=new classResources(b,a);c.showControls()}),$("#side-resources").hide("slide",{direction:"right"}),modifyCanvasAndImageWidth()}),$(".one-slide").live("click",function(a){a.preventDefault(),$("#text-editor").removeClass("minified");var b=$(this).find("img").attr("src"),c=new classResources(b,0);c.showControls()})})