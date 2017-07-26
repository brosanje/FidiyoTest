# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'

  resources :dashboard, only: [ :index ]
  resources :home, only: [ :index ]

  get "clients/ng", to: "clients#ng"
  get "clients/ng/*angular_route", to: "clients#ng"

  resources :clients, only: [ :index, :show ]
end
