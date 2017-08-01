# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'

  get "clients/ng", to: "clients#ng"
  get "clients/ng/*angular_route", to: "clients#ng"
  resources :clients, only: [ :index, :show ]

  resources :dashboard, only: [ :index ]
  get "dashboard/ng", to: "dashboard#ng"
  get "dashboard/ng/*angular_route", to: "dashboard#ng"

  resources :services, only: [ :index, :show ]
  get "services/showVideoLibrary", to: "services#showVideoLibrary"

  #get 'services/index'
  #get 'services/show'
  #get 'services/showVideoLibrary'
end
