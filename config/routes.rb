Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  resources :users, only: [:index, :show, :destroy]
  resources :items
  get 'history', to: 'items#history'
  post 'reallocate', to: 'items#reallocate'
  get 'deallocate', to: 'items#deallocate'
  resources :categories
  resources :brands
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
