class Vote < ActiveRecord::Base
  attr_accessible :story_card_id, :user_id, :value

  belongs_to :user
  belongs_to :story_card


  before_save :normalize_value

  def self.by_user_id_and_story_card_id user_id, story_card_id 
    where(:user_id => user_id).where(:story_card_id => story_card_id).limit(1).first
  end

  private

  def normalize_value
    self.value /= self.value.abs unless self.value == 0
  end
end
