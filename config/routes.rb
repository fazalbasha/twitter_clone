Rails.application.routes.draw do
  root to: "home#index"
  devise_scope :user do
    get '/sign-in' => "devise/sessions#new", :as => :login
  end
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :tweets, only: [:create, :update, :edit, :destroy] do
    post :retweet , on: :member
    delete :unretweet , on: :member
  end
  resources :users, only: [:show, :edit, :update] do
    member do
      post :follow
      delete :unfollow
    end
  end
  resources :conversations, only: :index do
    get '/open_chat' => "conversations#open_chat", :on => :collection
    post '/do_chat' => "conversations#do_chat"
  end
end
