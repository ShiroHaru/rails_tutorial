Rails.application.routes.draw do
  namespace :manage do
    #get 'users/new'
    resources :users
    get 'types/new'
  end
  namespace :admin do
    resources :types

    root to: "types#index"
  end
  namespace :manage do
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
