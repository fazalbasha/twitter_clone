Rails.application.routes.draw do
  root to: "home#index"
  resources :tweets
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, only: [:show] do
    member do
      post :follow
      delete :unfollow
    end
  end
end
