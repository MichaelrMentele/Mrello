Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do 
    namespace :v1 do
      resources :sessions, only: [:create] 

      resources :organizations, only: [:index, :create, :show]
      resources :join_requests, only: [:index, :create, :update, :destroy]

      resources :users, only: [:create, :update, :show]
      resources :lists, except: [:edit, :new]
      resources :cards, except: [:edit, :new]
      # TODO: resources :comments, only: [:create]
    end
  end
end

