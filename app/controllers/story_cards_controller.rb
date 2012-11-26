class StoryCardsController < ApplicationController

  before_filter :current_user_exists, :except => :index

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
    @story_card = StoryCard.new params[:story_card]
    @story_card.user_id = current_user.id
    if @story_card.save
      redirect_to @story_card.absolute_parent
    else
      flash.error = "Shit"
      redirect_to root_path
    end
  end

  def edit
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
    user = current_user

    @vote = Vote.by_user_id_and_story_card_id(user.id, story_card.id)
    if @vote
      @vote.update_attribute(:value, value)
    else
      @vote = Vote.create(:user_id => user.id, :story_card_id => story_card.id, :value => value)
    end

    respond_to do |format|
      format.json {render :json => {:value => value, :story_card_id => story_card.id} }
    end

  end


  private
  def current_user_exists
    redirect_to root_path unless current_user
  end

end
