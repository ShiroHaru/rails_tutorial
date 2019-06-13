Rails.application.routes.draw do
  namespace :manage do
    # root
    root 'static_pages#home'

    # users
    get '/signup', to: 'users#new'
    post '/signup', to: 'users#create'
    resources :users

    # types
    get 'types/new'

    # sessions
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    # account_activations
    resources :account_activations, only: [:edit]
    # password_reset
    resources :password_resets, only: [:new, :create, :edit, :update]

    # microposts
    resources :microposts, only: [:create, :destroy]

    # follow
    # memberメソッドを使うとユーザーidが含まれているURLを扱うようにる。
    # HTTPリクエスト	URL	                アクション	名前付きルート
    # GET	          /users/1/following	following	following_user_path(1)
    # GET	          /users/1/followers	followers	followers_user_path(1)
    resources :users do
      member do
        get :following, :followers
      end
    end
  end

  namespace :admin do
    resources :users

    root to: "users#index"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
