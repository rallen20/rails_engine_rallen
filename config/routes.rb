Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        resources :most_revenue, only: [:index]
        resources :revenue, only: [:index]
      end

      resources :merchants, only: [:index, :show] do
        get '/invoices', to: 'merchants/invoices#index'
        get '/items', to: 'merchants/items#index'
        get '/favorite_customer', to: 'merchants/favorite_customers#show'
      end

      namespace :invoices do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :invoices, only: [:index, :show] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/items', to: 'invoices/items#index'
        get '/invoice_items', to: 'invoices/invoice_items#index'
        get '/customer', to: 'invoices/customers#show'
        get '/merchant', to: 'invoices/merchants#show'
      end

      namespace :invoice_items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :invoice_items, only: [:index, :show] do
        get '/item', to: 'invoice_items/items#show'
        get '/invoice', to: 'invoice_items/invoices#show'
      end

      namespace :items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end

      resources :items, only: [:index, :show] do
        get '/invoice_items', to: 'items/invoice_items#index'
        get '/merchant', to: 'items/merchants#show'
      end
    end
  end
end
