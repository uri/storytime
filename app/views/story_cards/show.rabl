object @story_card
extends "story_cards/_story_card"

child(:replies => :replies) do
  extends "story_cards/_story_card"
end