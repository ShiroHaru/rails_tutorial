Rails.application.routes.draw do
  namespace :admin do
      resources :types

      root to: "types#index"
    end
  namespace :manage do
    get 'type/new'
  end
  namespace :manage do
    get 'test_admin/new'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
