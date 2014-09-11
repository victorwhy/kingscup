class Player < ActiveRecord::Base
  has_many :sessions
  has_many :games, through: :sessions
  has_many :cards, through: :sessions

  validates :name, presence: true
end
