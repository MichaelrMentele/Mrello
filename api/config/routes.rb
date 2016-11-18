Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do 
    namespace :v1 do
      resources :sessions, only: [:create] 
      resources :users, only: [:create]
      resources :lists, except: [:edit, :new]
      resources :cards, except: [:edit, :new]
      # TODO: resources :comments, only: [:create]
    end
  end
end

