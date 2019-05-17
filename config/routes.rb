Rails.application.routes.draw do
  namespace :manage do
    get 'type/new'
  end
  namespace :manage do
    get 'test_admin/new'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
