//= require jquery  
//= require jquery_ujs  
//= require_self  
//= require bootstrap-dropdown
//= require jquery.cycle

$(document).ready(function() {
  
  $('.secondary-nav').dropdown();
  
   $(".show-image").click(function() {
     $(this).next(".attached-image").toggle("slow");
   });

  /*
  setTimeout(function() {
      $('div.notice').fadeOut('slow');
    }, 5000);*/
      
  /*
   * Wiki test
   */
         
  $("#spellcheckinput").keyup(function () {
    var value = $(this).val();
    if (! value)
    return;
             
    url = 'http://en.wikipedia.org/w/api.php?action=opensearch&search='+value+'&format=json&callback=spellcheck';
               
    document.getElementById ('spellcheckresult').innerHTML = 'Checking ...';
    var elem = document.createElement ('script');
    elem.setAttribute ('src', url);
    elem.setAttribute ('type','text/javascript');
    document.getElementsByTagName ('head') [0].appendChild (elem);
  });

});

function spellcheck(data) {
  var found = false;
  var url='';
  var text = data [0];
                                    
  if (text != document.getElementById ('spellcheckinput').value)
    return;
                                                               
  for (i=0; i<data [1].length; i++) {
    if (text.toLowerCase () == data [1] [i].toLowerCase ()) {
      found = true;
      url ='http://en.wikipedia.org/wiki/' + text;
      document.getElementById ('spellcheckresult').innerHTML = '<b style="color:green">Correct</b> - <a target="_top" href="' + url + '">link</a>';
    }
  }
                                                                           
  if (! found)
    document.getElementById ('spellcheckresult').innerHTML = '<b style="color:red">Incorrect</b>';
};
