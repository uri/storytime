class StoryCardsController < ApplicationController

  before_filter :load_user, :except => :index

  def index
    @story_cards = StoryCard.main_threads
    respond_to do |format|
      format.html
      format.json
      format.xml
    end
  end

  def replies
    @story_card = StoryCard.find params[:id]
    @story_cards = @story_card.replies
    respond_to do |format|
      format.html 
      format.json
      format.xml

      render "index" and return
    end
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
    @story_card.user_id = @user.id

    respond_to do |format|
      if @story_card.save
        format.html { redirect_to @story_card.absolute_parent }
        format.json
        format.xml
      else
        format.html do
          flash.error = "Shit"
          redirect_to root_path
        end
        format.json {render :json => {:errors => @story_card.errors.full_messages}}
        format.xml {render :xml => {:errors => @story_card.errors.full_messages}}
        
      end
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

    @vote = Vote.by_user_id_and_story_card_id(@user.id, story_card.id)
    if @vote
      @vote.update_attribute(:value, value)
    else
      @vote = Vote.create(:user_id => @user.id, :story_card_id => story_card.id, :value => value)
    end

    respond_to do |format|
      format.json {render :json => {:value => value, :story_card_id => story_card.id} }
    end

  end


  private
  def load_user
    puts params
    if request.format.json? || request.format.xml? 
      request_sym = request.format.to_s.split("/")[-1].to_sym
      if params.has_key?(:token)
        # Continue...
        @user = User.find_by_token params[:token]
        render request_sym => { :error => "No user with toke nexists"} if @user.nil?
      else
        #Render errors
        render request_sym => { :error => "You must provide an API token"}
      end
    else
      if signed_in?
        @user = current_user
      else
        redirect_to root_path
      end
    end
  end

end
