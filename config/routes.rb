Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        get '/invoices', to: 'merchant_invoices#index'
        get '/items', to: 'merchant_items#index'
      end
    end
  end
end
