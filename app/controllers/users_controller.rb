class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user, only: [:show, :follow, :unfollow, :edit, :update]
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

  def edit

  end

  def update
    #@user.avatar.attach(params[:user][:avatar])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User profile updated successfully.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :title, :bio, :location)
  end
end
