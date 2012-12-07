object @user

attributes :id, :name

node(:upvotes) {|user| user.upvote_count}
node(:downvotes) {|user| user.downvote_count}

child(StoryCard.where(:user_id => @user.id).order("created_at DESC").limit(3) => :story_cards) { |user| 
    attributes :content, :id
}