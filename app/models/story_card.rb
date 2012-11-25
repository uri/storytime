class StoryCard < ActiveRecord::Base
  attr_accessible :content, :user_id, :parent_id

  has_many :votes
  belongs_to :story_card, :foreign_key => :parent_id

  validates :content, :length => {:maximum => 140}

  def self.main_threads
    StoryCard.select{|c| c.parent_id == nil}
  end

  def replies
    StoryCard.where("parent_id = ?", self.id)
  end
end
