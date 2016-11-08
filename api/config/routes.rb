Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do 
    namespace :v1 do 
      resources :users, only: [:create, :show]
      resources :lists, only: [:index, :create, :show]
    end
  end
end