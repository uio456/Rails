Rails.application.routes.draw do
  get 'plans/index'
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
  resources :posts do
    resources :comments, only: [:create, :destroy]
    # member do
      # post :comment
    # end
  end
  resources :plans do
    member do
      post :confirm
    end
    resources :comments, only: [:create, :destroy]
  end
  resources :members do
    member do
      get :drafts
      post :change_role
      # post :add_friend
      # post :unfriend
      # post :accept
      # post :ignore
    end
  end
  post "/members/:member_id/plans/:plan_id", to: "members#invite", :as => :invite

  resources :friendships, only: [:create, :destroy] do
    member do
      post :cancelled
      post :accept
      post :ignore
    end
  end

  root "welcomes#index"
end
