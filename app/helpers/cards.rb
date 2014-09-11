def find_cardid(card)
  value = card[:value].to_i
  if card["suit"] == "D"
    suit = "diamonds"
  elsif card["suit"] == "C"
    suit =  "clubs"
  elsif card["suit"] == "H"
    suit =  "hearts"
  elsif card["suit"] == "S"
    suit = "spades"
  end
  cardid = Card.where(value: value, suit: suit).first.id
end