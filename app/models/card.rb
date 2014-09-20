class Card < ActiveRecord::Base
  has_many :sessions
  has_many :players, through: :sessions
  has_many :games, through: :sessions

end
