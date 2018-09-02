Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :tweets do
    post :retweet , on: :member
    delete :unretweet , on: :member
  end
  resources :users, only: [:show] do
    member do
      post :follow
      delete :unfollow
    end
  end
end
