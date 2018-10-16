Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  # post '/search', to: 'welcome#search'
  resources :scrapers, only: [:create, :new, :show, :index]
  resources :shops, only: [:create, :new]
end
