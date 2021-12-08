Rails.application.routes.draw do
  resources :mismatched_indices
  resources :steps
  resources :revealed_indices
  resources :games
  root 'games#generate'
  resources :words
  post 'games/check_step', to: 'games#check_step'
  # get 'photos/:id', to: 'photos#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
