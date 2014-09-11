$(document).ready(function() {
  $('li a').click(function(event){
    event.preventDefault
    $.ajax({
      url: '/game/'+$(this).data("gameid"),
      type: 'GET',
      dataType: 'json'
    }).done(function(response){
      console.log(response);
      // appendPastPlayers(response);
    }).fail(function(response){
      console.log('FAIL');
    });
  })

});

  // at some point pass the whole game object
  // function appendPastGame(game_object) {
  //   for(i=1; i<=game_object.length; i++) {
  //     console.log(game_object[i]);
  //   };
  // };

function appendPastPlayers(players){

}