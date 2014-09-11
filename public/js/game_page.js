$(document).ready(function() {
  $('li a').click(function(event){
    event.preventDefault;
    gameId= $(this).data("gameid");
    console.log(gameId);
    $.ajax({
      url: '/game/'+gameId,
      type: 'GET',
      dataType: 'json'
    }).done(function(response){
      appendPastPlayers(response, gameId);
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

function appendPastPlayers(players, id){
  gameElement = $("ul").find("[data-gameid='" + id + "']")
  gameElement.append('</a><br>')
  for(i=0; i<players.length; i++){
    gameElement.append(players[i].name+ ', ');
  }

}