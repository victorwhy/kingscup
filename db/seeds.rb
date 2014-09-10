suits = ['diamonds','hearts','clubs','spades']

suits.each do |suit|
  (1..13).each do |value|
    Card.create(suit: suit, value: value)
  end
end

Game.create

Game.update_cards(Card.all)

Player.create(name: "Victor", email: "victor@dbc.com")
Player.create(name: "Shiraj", email: "shiraj@dbc.com")
Player.create(name: "Jeremy", email: "jeremy@dbc.com")
Player.create(name: "Daniel", email: "daniel@dbc.com")

test_array = (1..52).to_a.shuffle

(1..13).each do |num|
  Session.create(player_id: 1, card_id: test_array.pop, game_id: 1)
  Session.create(player_id: 2, card_id: test_array.pop, game_id: 1)
  Session.create(player_id: 3, card_id: test_array.pop, game_id: 1)
  Session.create(player_id: 4, card_id: test_array.pop, game_id: 1)
end