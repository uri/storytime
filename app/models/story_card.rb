class StoryCard < ActiveRecord::Base
  attr_accessible :content, :user_id, :parent_id

  has_many :votes
  belongs_to :story_card, :foreign_key => :parent_id
  belongs_to :user

  validates :content, :length => {:maximum => 140}, :presence => true

  before_save :clean_whitespace



  def self.main_threads
    now = Time.now
    StoryCard.select{|c| c.parent_id == nil}.sort_by{|card| [-card.score, now - card.created_at] }
  end

  def replies
    StoryCard.where("parent_id = ?", self.id).sort{|a,b| b.score <=> a.score}
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

  def score
    # This is horrible
    upvotes_count - downvotes_count
  end

  private
  def clean_whitespace
    # self.content = self.content.tr("\n\r", "")
  end

end
