$(document).ready(function() {
  $('li a').click(function(event){
    event.preventDefault
    $.ajax({
      url: '/game/'+$(this).data("gameid"),
      type: 'POST',
      data: $(this).serialize(),
      dataType: 'json'
    }).done(function(responseData){
      // for(i=1; i<=responseData.length; i++) {
      //   console.log(responseData[i]);
      // };
      appendPastGame(responseData);
    }).fail(function(responseData){
      console.log('FAIL');
    });
  })

});

  function appendPastGame(game_object) {
    for(i=1; i<=game_object.length; i++) {
      console.log(game_object[i]);
    };
  };
