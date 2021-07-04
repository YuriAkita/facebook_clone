Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get '/',to: "blogs#index"

  resources :blogs do
    collection do
      post :confirm
    end
  end

  resources :conversations do
    resources :messages
  end

  resources :users, only: [:index, :new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
