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

get '/game/finish' do
  session[:game] = nil
  erb :'/game/show'
end
# get '/game/test' do
#   erb :'/game/play'
# end

get '/game/test' do
  erb :'/game/play'
end


get '/game/:id' do
  game = Game.find(params[:id])
  @players = game.players
  @players.uniq.to_json

  # @game_object = players.each_with_object({}) do |player, game_hash|
  #   game_hash[player.name] = player.cards
  # end
  # @game_object.to_json
end

post '/game/:id' do
  cardarray = []
  for i in 0..(params[:players].length-1)
    player_id = params[:players][i.to_s][:id].to_i
    cards = params[:players][i.to_s][:cards]
    game_id = session[:game]

    cards.each do |card|
      card_id = find_cardid(card[1])
      cardarray << card_id
      sessions = Session.where(game_id: game_id, card_id: card_id)
      sessions[0].update(player_id: player_id)
    end
  end
  # binding.pry
  # redirect '/game/finish'
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
