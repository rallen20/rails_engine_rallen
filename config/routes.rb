Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
        get '/most_revenue', to: 'most_revenue#index'
      end
      resources :merchants, only: [:index, :show] do
        get '/invoices', to: 'merchants/invoices#index'
        get '/items', to: 'merchants/items#index'
      end
      namespace :invoices do
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
      end
      resources :invoices, only: [:index, :show] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/items', to: 'invoices/items#index'
      end
    end
  end
end
