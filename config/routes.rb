Rails.application.routes.draw do
  resources :weather, only: %i[index create show]

  root 'weather#index'
end
