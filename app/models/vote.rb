class Vote < ActiveRecord::Base
  attr_accessible :story_card_id, :user_id, :value

  belongs_to :user
  belongs_to :story_card
end
