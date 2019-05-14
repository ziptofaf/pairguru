Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"

  resources :comments, only: [:create, :destroy] do
    collection do
      get :top_commenters
    end
  end
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end

  namespace :api do
    resources :movies, only: [:index, :show]
    namespace :v2 do
      resources :movies, only: [:index, :show]
    end
  end
end
