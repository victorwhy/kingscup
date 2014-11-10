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

function showPastPlayers(players, id){
  $('.showplayers').hide('slow');
  gameElement = $("ul").find("[data-gameid='" + id + "']");
  var playerList = '';
  for(i=0; i<players.length; i++){
    playerList += players[i].name+ ', ';
  }
  playerList = playerList.substring(0, playerList.length - 2);
  gameElement.append('<div class="showplayers" id="show' + id + '" style="display: none;">'+ playerList);
  $('#show'+id).show('slow');
}