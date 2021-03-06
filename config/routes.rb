Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get '/:merchant_id/items', to: 'items#index'
        get '/most_revenue', to: 'statistics#most_revenue'
        get '/most_items', to: 'statistics#most_items'
        get '/:merchant_id/revenue', to: 'statistics#show'
      end

      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get '/:item_id/merchants', to: 'merchants#show'
      end

      namespace :invoices do
        get 'most_expensive', to: 'statistics#most_expensive'
      end

      resources :merchants
      resources :items
      resources :revenue, only: [:index]
    end
  end
end
