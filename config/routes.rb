Rails.application.routes.draw do
  get 'rooms/index'
  get 'rooms/show'
  get 'chamber_purposes/index'
  get 'chamber_purposes/show'
  get 'dungeon_purposes/index'
  get 'dungeon_purposes/show'
  get 'dungeons/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
