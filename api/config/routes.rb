Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do 
    namespace :v1 do
      resources :sessions, only: [:create, :destroy] 
      resources :users, only: [:create, :show]
      resources :lists, only: [:index, :create, :show]
      resources :cards, only: [:create, :show]
      resources :comments, only: [:create]
    end
  end
end
