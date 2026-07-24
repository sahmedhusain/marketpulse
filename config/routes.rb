Rails.application.routes.draw do
  resources :line_items do
    member do
      put :decrement
      patch :decrement
    end
  end
  resources :carts
  resources :products
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  get '/.well-known/*path', to: proc { [204, {}, ['']] }
  root 'products#index'
end


