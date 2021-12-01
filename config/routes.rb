Rails.application.routes.draw do
  resources :steps
  resources :revealed_indices
  resources :games
  root 'words#generate_word'
  resources :words
  # get 'photos/:id', to: 'photos#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
