class StoryCard < ActiveRecord::Base
  attr_accessible :content, :user_id, :parent_id

  has_many :votes
  belongs_to :story_card, :foreign_key => :parent_id
  belongs_to :user

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

  def absolute_parent
    current_id = self.id
    found = self

    while found.parent_id
      current_id = found.parent_id
      found = StoryCard.find(found.parent_id)
    end 

    StoryCard.find current_id
  end

  def upvotes_count
    Vote.where(:story_card_id => self.id, :value => 1).count
  end

  def downvotes_count
    Vote.where(:story_card_id => self.id, :value => -1).count
  end


end
