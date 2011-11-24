$("#wiki-submit").live('click', function(e) {
  var title = $("#wiki-term-input").val();
  if (!title) {
    $(this).after('<span class="empty-notice label warning">Please add a term to search on Wikipedia</span>');
    setTimeout(function() {
      $(".empty-notice").fadeOut('slow');
    }, 5000);
    return;
  }
  e.preventDefault();
  $(".pull-resource").hide();
  $("#wiki-finder-results #not-found").remove();
  $("#wiki-finder-results").addClass("loading");
  $("#wiki-finder-results p, #wiki-finder-results a.wiki-read-more").remove();
  $("#side-resources").show("slide", {direction: "right"});
  $("#wiki-results").show("slide", {direction: "right"});
  $("#text-editor").addClass("minified");
  modifyCanvasAndImageWidth();
  
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
      if (data [1].length == 0) {
        return $("#wiki-finder-results").removeClass("loading").append('<span class"label" id="not-found">Sorry, I can\'t find that term on Wikipedia.</span>');
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
        wikipage.addClass("wiki-content");
        wikipage.find('sup').remove();
        wikipage.find('a').each(function() {
          $(this)
          .attr('href', 'http://en.wikipedia.org'+$(this).attr('href'))
          .attr('target','wikipedia');
        });
        $("#wiki-finder-results").removeClass("loading");
        $("#wiki-finder-results #not-found").remove();
        $("#wiki-finder-results").append(wikipage);
        $("#wiki-finder-results").append('<a class="wiki-read-more" href="http://en.wikipedia.org/wiki/'+title+'" target="wikipedia"">Read more on Wikipedia</a>');
        $("#wiki-finder-results").append('<p><a href="#" class="btn" id="copy-wiki">Copy to the lesson</a></p>');
      }
      });
    }
  });
});

$("#copy-wiki").live('click', function(e) {
  e.preventDefault();
  var wikiContent = $(this).parent().parent().find(".wiki-content");
  var wikiReadMore = $(this).parent().parent().find(".wiki-read-more");
  var text = new TextEditor();
  text.showControls();
  text.savedText(wikiContent);
  text.savedText(wikiReadMore);
  
  $(this).remove();
  $("#side-resources").hide("slide", {direction: "right"});
  $("#text-editor").removeClass("minified");
  modifyCanvasAndImageWidth();
});