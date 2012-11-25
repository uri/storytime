class StoryCardsController < ApplicationController

  def index
    @story_cards = StoryCard.main_threads
  end

  def show
    @story_card = StoryCard.find params[:id]
  end

  def new
    @story_card = StoryCard.new
  end

  def create
    puts params
    success=StoryCard.create params[:story_card]
    redirect_to root_path
  end

  def edit
    @story_card = StoryCard.find params[:id]
  end

  def update
  end

  def destroy
  end

  def reply
    @parent = StoryCard.find params[:id]
    @story_card = StoryCard.new
    @story_card.parent_id = @parent.id
  end

  def vote
    value = params[:value]
    story_card = StoryCard.find params[:id]
  end


end
