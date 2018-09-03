class HomeController < ApplicationController
  def index
    @user = User.friendly.find(current_user.id) if current_user
    @tweet = Tweet.new
    @tweets = Tweet.includes(:user).order(created_at: 'desc')
  end
end
