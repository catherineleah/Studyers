// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(document).ready(function() {

   $(".show-image").click(function() {
     $(this).next(".attached-image").toggle("slow");
   });

   if ($("#home-wrapper #cycle")) {
    $("#home-wrapper #cycle").cycle({
      fx: 'fade',
      timeout: 6000, // milliseconds between slide transitions
      pause: 1,
      cleartype: 1,
      cleartypeNoBg: 1
     });
  }

  $(".delete-notebook a, .new-notebook a").poshytip({
      className: 'tip-twitter',
            showTimeout: 1,
            alignTo: 'target',
            alignX: 'left',
            alignY: 'center',
            offsetX: 5,
            allowTipHover: false,
            fade: false,
            slide: false
        });

        $(".edit-notebook a").poshytip({
          className: 'tip-twitter',
          showTimeout: 1,
          alignTo: 'target',
          alignX: 'right',
          alignY: 'center',
          offsetX: 5,
          allowTipHover: false,
          fade: false,
          slide: false
        });

        $(".edit-lesson a, .delete-lesson a").poshytip({
          className: 'tip-twitter',
          showTimeout: 1,
          alignTo: 'target',
          alignX: 'center',
          alignY: 'bottom',
          offsetX: 0,
          offsetY: 5,
          allowTipHover: false,
          fade: false,
          slide: false
        });

        setTimeout(function() {
              $('.notice').fadeOut('slow');
        }, 5000);
      
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
