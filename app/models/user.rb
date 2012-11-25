class User < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :story_cards
  has_many :votes
end
