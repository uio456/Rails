Rails.application.routes.draw do
  get 'members/index'
  get 'welcome/index'
  devise_for :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :candidates do
    member do
      post :vote
    end
  end
  resources :welcomes, only: [:index]
  resources :members do
    member do
      post :add_friend
      post :unfriend
      post :accept
      post :ignore
    end
  end

  resources :friendships, only: [:create, :destroy] do
    member do
      post :accept
      post :ignore
    end
  end

  root "welcomes#index"
end
