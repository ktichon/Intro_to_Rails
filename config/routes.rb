Rails.application.routes.draw do

  get 'home/index'
  get 'about/index'
  resources :adventures, only: [:index, :show]
  resources :chamber_purposes, only: [:index, :show]
  resources :dungeon_purposes, only: [:index, :show]
  resources :rooms, only: [:index, :show]
  resources :dungeons, only: [:index, :show]

  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
