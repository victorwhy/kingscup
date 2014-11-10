class Game < ActiveRecord::Base

  has_many :sessions
  has_many :players, through: :sessions
  has_many :cards, through: :sessions
  belongs_to :user


  @@default_rules = {
    1 => "Waterfall",
    2 => "You - pick someone to drink",
    3 => "Me - you have to drink",
    4 => "Floor - last person to touch floor drinks",
    5 => "Guys - men have to drink",
    6 => "Chicks - women have to drink",
    7 => "Heaven - last person to point up drinks",
    8 => "Mate - pick someone and they drink when you drink",
    9 => "Rhyme",
    10 => "Categories",
    11 => "Make a rule",
    12 => "Questions",
    13 => "Pour some into the King's cup!"
  }

  def self.default_rules
    @@default_rules
  end

  def update_rules(rules, cards)
    cards.each do |card|
      card.rule = rules[card.value]
      card.save
    end
  end
end

