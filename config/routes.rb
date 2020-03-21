Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resource :dashboard, controller: 'dashboard', only: :show
  resources :blogs, only: %i[show new create]
  resources :posts, only: %i[create]
end
