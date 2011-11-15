function wikiFinder(ID, putAfter) {
  this.ID = ID;
  this.containerDiv = document.createElement("div");
  this.containerDiv.className = "wiki-container";
  this.containerDiv.id = "wiki-container-" + this.ID;
  if (putAfter) {
    $(putAfter).after(this.containerDiv);
    $(this.containerDiv).hide().show("slow");
  }
  else {
    $("#text-editor").append(this.containerDiv);
    $(this.containerDiv).hide().show("slow");
  }
  
  this.wikiForm = document.createElement("form");
  this.wikiForm.className = "wiki-form dont-save";
  this.wikiForm.id = "wiki-form-" + this.ID;
  
  this.containerDiv.appendChild(this.wikiForm);
  
  this.wikiDiv = document.createElement("div");
  this.wikiDiv.className = "wiki-wrapper";
  this.wikiDiv.id = "wiki-wrapper-" + this.ID;
  
  this.containerDiv.appendChild(this.wikiDiv);
  
  $("#wiki-form-" + this.ID).append('<label for="wiki-value">Search for a term in Wikipedia</label><input type="text" class="wiki-value" id="wiki-term-' + this.ID + '" autocomplete="off" />');
  $("#wiki-form-" + this.ID).append('<div class="wiki-find btn" id="wiki-submit-'+ this.ID +'">Find on Wikipedia</div>');
  
  var submitDiv = document.getElementById("wiki-submit-" + this.ID);
  //console.log(submitDiv);
  submitDiv.addEventListener('click', function() {wikiFind(ID)}, false)
  
  $("#wiki-container-" + this.ID).after(buttonsAppend("#wiki-container-" + this.ID));
}
function wikiFind(ID) {
  var title = $("#wiki-term-" + ID).val();
  if (!title) {
    $("#wiki-wrapper-" + ID).append("Please add a term to search on Wikipedia");
  }
  var checkIfExists = false;
  
  $.ajax({
    url: 'http://en.wikipedia.org/w/api.php',
    data: {
      action:'opensearch',
      search:title,
      format:'json'
    },
    dataType:'jsonp',
    success: function(data, textStatus, jqXHR) {
      console.log(data);
      if (data [1].length == 0) {
        return $("#wiki-wrapper-" + ID).append("Sorry, I can't find that term on Wikipedia.");
      }
      title = title.replace(' ', '_');
      $.ajax({
        url: 'http://en.wikipedia.org/w/api.php',
        data: {
        action:'parse',
        prop:'text',
        page:title,
        format:'json'
      },
      dataType:'jsonp',
      success: function(data) {
        wikipage = $("<div>"+data.parse.text['*']+"<div>").children('p:first');
        wikipage.find('sup').remove();
        wikipage.find('a').each(function() {
          $(this)
          .attr('href', 'http://en.wikipedia.org'+$(this).attr('href'))
          .attr('target','wikipedia');
        });
        $("#wiki-wrapper-" + ID).append(wikipage);
        $("#wiki-wrapper-" + ID).append("<a href='http://en.wikipedia.org/wiki/"+title+"' target='wikipedia'>Read more on Wikipedia</a>");
      }
      });
    }
  });
}