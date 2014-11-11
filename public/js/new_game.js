$(document).ready(function() {
  var numofplayers = 2; 

  $('button.button-link').click(function(event){
    event.preventDefault();
    $('.player_container').append(addPlayer(numofplayers));
    numofplayers++;
  });
});

function addPlayer(numofplayers) {
  var htmlAppend = '<input type="text" class="new_player" name="player['+numofplayers+']" placeholder="Player '+numofplayers+'" data-playernum="'+numofplayers+'"><br>';
  return htmlAppend;
};