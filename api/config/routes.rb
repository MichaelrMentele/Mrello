Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do 
    namespace :v1 do
      post 'login', to: 'sessions#create' 
      post 'logout', to: 'sessions#destroy'
      resources :users, only: [:create, :show]
      resources :lists, except: [:edit, :new]
      resources :cards, except: [:edit, :new]
      # TODO: resources :comments, only: [:create]
    end
  end
end

