Rails.application.routes.draw do
  get 'welcome/index'
  devise_for :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :candidates do
    member do
      post :vote
    end
  end
  resources :welcomes, only: [:index]

  root "welcomes#index"
end
