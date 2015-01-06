Rails.application.routes.draw do
  resources :users, except: [:new, :edit] do
    resources :contacts, only: [:index]
    member do
      get 'comments'
      get 'fav_contacts'
    end
    resources :contact_groups, only: [:index]
  end

  resources :contacts, only: [:show, :create, :update, :destroy] do
    member do
      get 'comments'
    end
  end

  # get '/users(.:format)', to: 'users#index', as: 'users'
  # post '/users(.:format)', to: 'users#create'
  # get '/users/new(.:format)', to: 'users#new', as: 'new_user'
  # get '/users/:id/edit(.:format)', to: 'users#edit', as: 'edit_user'
  # get '/users/:id(.:format)', to: 'users#show', as: 'user'
  # patch 'users/:id(.:format)', to: 'users#update'
  # put 'users/:id(.:format)', to: 'users#update'
  # delete 'users/:id(.:format)', to: 'users#destroy'

end
