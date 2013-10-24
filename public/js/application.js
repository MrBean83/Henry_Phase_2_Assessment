$(document).ready(function() {
  $('form#create-event').on('submit', function(e) {
    e.preventDefault();

      var data = $('#create-event').serialize()
      var buttons = $('.buttons:first').html();
      
    $.post('/events/create/ajax', data, function(response) { 
      console.log(response);
      $('ol#events').append("<li>" + response + buttons + "</li><br>");  
    })
  });
});
