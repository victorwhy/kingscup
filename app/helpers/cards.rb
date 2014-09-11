def find_card(card)
  value = card[:value].to_i
  if card[:suit] = "D"
    suit = "diamonds"
  elsif card[:suit] = "C"
    suit =  "clubs"
  elsif card[:suit] = "H"
    suit =  "hearts"
  else
    suit = "spades"
  end
  
  Card.find_by(value: value, suit: suit)
end