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

  def total_reply_count
    count = 0
    children = [self.id]
    while not children.empty?
      current = StoryCard.find children.pop
      count += 1
      children += current.replies.map {|r| r.id}
    end
    count
  end


end
