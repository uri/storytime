object @story_card
attributes :id, :parent_id, :content
node(:author_name) {|story_card| story_card.user.name}
node(:total_replies) {|story_card| story_card.total_reply_count}

node(:upvotes) { |story_card| story_card.upvotes_count}
node(:downvotes) { |story_card| story_card.downvotes_count}