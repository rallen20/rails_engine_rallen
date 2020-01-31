Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
        resources :most_revenue, only: [:index]
        resources :revenue, only: [:index]
      end

      resources :merchants, only: [:index, :show] do
        get '/invoices', to: 'merchants/invoices#index'
        get '/items', to: 'merchants/items#index'
        get '/favorite_customer', to: 'merchants/favorite_customer#show'
      end

      namespace :invoices do
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
      end

      resources :invoices, only: [:index, :show] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/items', to: 'invoices/items#index'
        get '/invoice_items', to: 'invoices/invoice_items#index'
        get '/customer', to: 'invoices/customer#show'
        get '/merchant', to: 'invoices/merchant#show'
      end

      resources :invoice_items, only: [:index, :show]
    end
  end
end
