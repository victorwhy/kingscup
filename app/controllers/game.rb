get '/game' do
  erb :game
end

post '/game/:id' do
  game = Game.find(params[:id])
  players = game.players
  @game_object = players.each_with_object({}) do |player, game_hash|
    game_hash[player.name] = player.cards
  end
  @game_object.to_json
end

# players.each_with_object {} do |player, game_object|
#   game_object << {(player.name): player.cards}
# end.to_json

# arr = []
# collection.each do |x|
#   arr << x
# end
# arr

# collection.each_with_object [] { |x, arr| arr << x }.to_json
