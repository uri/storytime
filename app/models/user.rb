class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  has_many :story_cards
  has_many :votes

  validates :name, :format => { :with => /^[a-zA-Z0-9\-_]+$/ }, :uniqueness => true
  validates :password, :presence => true
  validates :password_confirmation, :presence => true

  before_save :generate_token

  def update_token
    token = SecureRandom.base64(64)
    update_attribute(:token, token)
  end

  def upvote_count
    StoryCard.where(:user_id => self.id).inject(0) { |sum, card| sum += card.upvotes_count }
  end

  def downvote_count
    StoryCard.where(:user_id => self.id).inject(0) { |sum, card| sum += card.downvotes_count }
  end

  private 

  def generate_token
    self.token = SecureRandom.base64 64
  end

end
