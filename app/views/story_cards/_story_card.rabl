object @story_card
attributes :id, :parent_id, :content, :user_id

node(:upvotes) { |story_card| story_card.upvotes_count}
node(:downvotes) { |story_card| story_card.downvotes_count}