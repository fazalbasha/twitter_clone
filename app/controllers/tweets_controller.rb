class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweet, :unretweet]

  # GET /tweets
  # GET /tweets.json
  def index
    @user = User.friendly.find(current_user.id) if current_user
    @tweet = Tweet.new
    @tweets = Tweet.includes(:user).order(created_at: 'desc')
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.js { render layout: false }
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render json: @tweet, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.js { render layout: false }
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def retweet
    @tweet.re_tweets.create(user_id: current_user.id)
    respond_to :js
  end

  def unretweet
    @retweet = @tweet.re_tweets.find_by(user_id: current_user.id)
    @retweet.destroy
    respond_to :js
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:body, :user_id, :image)
    end
end
