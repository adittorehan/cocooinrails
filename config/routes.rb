Rails.application.routes.draw do
  resources :users do
    resources :blogs
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  get 'error', to: 'users#error', as: 'error'
end
