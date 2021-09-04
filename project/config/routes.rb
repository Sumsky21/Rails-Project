Rails.application.routes.draw do
  resources :orders
  resources :cart_items do
    collection do
      get 'increase'
      get 'decrease'
    end
  end
  resources :addresses
  resources :categories
  root to: 'items#index'
  resources :items do
    resources :comments
  end
  # Use custom controllers for user
  devise_scope :user do
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    }
    # root 'users/sessions#create'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
