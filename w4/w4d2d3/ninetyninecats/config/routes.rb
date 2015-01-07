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

  root to: 'cats#index'
end
