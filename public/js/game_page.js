$(document).ready(function() {
  $('li.clickable').click(function(event){
    event.preventDefault;
    gameId= $(this).data("gameid");
    console.log(gameId);
    $.ajax({
      url: '/game/'+gameId,
      type: 'GET',
      dataType: 'json'
    }).done(function(response){
      showPastPlayers(response, gameId);
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

function showPastPlayers(players, id){
  $('.showplayers').hide('slow');
  gameElement = $("ul").find("[data-gameid='" + id + "']");
  var playerList = '';
  for(i=0; i<players.length; i++){
    playerList += players[i].name+ ', ';
  }
  gameElement.append('<div class="showplayers" id="show' + id + '" style="display: none;"><br>Players: '+ playerList);
  $('#show'+id).show('slow');
}