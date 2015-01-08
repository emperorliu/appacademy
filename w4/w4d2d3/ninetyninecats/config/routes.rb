Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:index, :new]
  end

  resources :cat_rental_requests, except: [:index, :new] do
    member do
      get 'approve'
      get 'deny'
    end
  end

  resource :user, only: [:create, :new, :show]
  resource :session, only: [:create, :destroy, :new]

  root to: 'cats#index'
end
