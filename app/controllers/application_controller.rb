class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to login_url
    end
  end

  def set_who_to_follow
    if current_user
      ids = current_user.all_following.collect{ |c| c.id } << current_user.id
      @who_to_follow = User.where.not(id: ids)
    else
      @who_to_follow = User.all
    end
  end
end
