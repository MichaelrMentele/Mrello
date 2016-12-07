Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do 
    namespace :v1 do
      resources :sessions, only: [:create] 

      resources :users, only: [:create, :update, :show]

      resources :boards, only: [:create, :index, :show]
      resources :lists, except: [:edit, :new]
      resources :cards, except: [:edit, :new]

      resources :organizations, only: [:index, :create, :show]
      resources :memberships, only: [:index, :create, :update, :destroy]
    end
  end
end

