get '/game' do
  erb :'/game/show'
end

post '/game' do

  @game = Game.create(user_id: session[:current_user])
  
  params[:player].each do |num, player|
    @game.players << Player.find_or_create_by(name: player)
  end

  new_rules = {}

  params[:newrules].each do |key, rule|
    new_rules[key.to_i] = rule
  end

  @game.update_rules(new_rules, Card.all)
  
  @game.cards << Card.all
  session[:game] = @game.id
  # @game.to_json
  erb :'/game/play'
end

get '/game/new' do
  @rules = Game.default_rules
  erb :'/game/new'
end

get '/game/test' do
  erb :'/game/play'
end

get '/game/:id' do
  game = Game.find(params[:id])
  @players = game.players
  @players.to_json

  # @game_object = players.each_with_object({}) do |player, game_hash|
  #   game_hash[player.name] = player.cards
  # end
  # @game_object.to_json
end

post '/game/:id' do
  
  for i in 0..(params[:players].length-1)
    player_id = params[:players][i.to_s][:id].to_i
    cards = params[:players][i.to_s][:cards]
    
    cards.each do |card|
      card_id = find_card(card[1]).id
      sessions = Session.find_by(game_id: session[:game], card_id: card_id)
      sessions.player_id = player_id
      sessions.save
    end
  end
  session[:game] = nil
  redirect '/game'
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
