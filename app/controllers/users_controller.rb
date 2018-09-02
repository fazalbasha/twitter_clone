class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @tweets = @user.tweets
  end
end
