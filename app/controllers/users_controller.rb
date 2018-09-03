class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user, only: [:show, :follow, :unfollow]
  before_action :set_who_to_follow

  def show
    @user = User.friendly.find(params[:id])
    @tweets = @user.tweets.order(created_at: 'desc')
  end

  def follow
    current_user.follow(@user)
    respond_to :js
  end

  def unfollow
    current_user.stop_following(@user)
    respond_to :js
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.friendly.find(params[:id])
  end
end
