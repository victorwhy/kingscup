get '/game' do
  erb :'/game/show'
end

post '/game' do
  binding.pry

  @game = Game.create
  
  params[:player].each do |num, player|
    @game.players << Player.find_or_create_by(name: player)
  end

  @new_rules = {}

  params[:newrules].each do |key, rule|
    @new_rules[key.to_i] = rule
  end

end

post '/game/:id' do
  game = Game.find(params[:id])
  players = game.players
  @game_object = players.each_with_object({}) do |player, game_hash|
    game_hash[player.name] = player.cards
  end
  @game_object.to_json
end

get '/game/new' do
  # @rules = Game.default_rules
  erb :'/game/new'
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
