$(document).ready(function() {
  $.ajax({
    url: '/game/'+$('#playscreen').data("gameid"),
    type: 'GET',
    dataType: 'json'
  }).done(function(response){
    console.log(response);
    createPlayers(response);
  }).fail(function(response){
    console.log('FAIL');
  });

  $('#backcard').click(function(){
    playerHover(currentPlayer);
    $('#frontcard').html(nextCard());
    gameOver();
    incrementPlayer();
  });
});

var gameArray = [];
var players = [];
var kings = [];
currentPlayer = 0;


Array.prototype.shuffle = function() {
  var i = this.length, j, temp;
  if ( i == 0 ) return this;
  while ( --i ) {
     j = Math.floor( Math.random() * ( i + 1 ) );
     temp = this[i];
     this[i] = this[j];
     this[j] = temp;
  }
  return this;
}

function Player(player){
  this.name = player.name;
  this.id = player.id;
  this.cards = [];
}

function Card(suit, value){
  this.suit = suit;
  this.value = value;
  this.imgValue = alpha(value);
}

function createPlayers(newplayers){
  for(i=0; i<newplayers.length; i++){
    players.push(new Player(newplayers[i]));
  };
}

for(i=1; i<=13; i++){
  gameArray.push(new Card('C', i));
  gameArray.push(new Card('D', i));
  gameArray.push(new Card('H', i));
  gameArray.push(new Card('S', i));
};

gameArray = gameArray.shuffle()

function nextCard(){
  card = gameArray.pop();
  imageText = card.imgValue + card.suit + '.svg';
  return '<img src = "/images/' + imageText + '">';
}

function Player(name){
  this.name = name;
}

function Card(suit, value){
  this.suit = suit;
  this.value = value;
  this.imgValue = alpha(value);
}

//helpers
function alpha(value){
  switch (value) {
  case 1:
    return 'A';
    break;
  case 11:
    return 'J';
    break;
  case 12:
    return 'Q';
    break;
  case 13:
    return 'K';
    break;
  default:
    return value;
  }
}


//view
function flipCard(card){
  $('#frontcard').html()
}