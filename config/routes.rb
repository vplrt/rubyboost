Rails.application.routes.draw do
  devise_for :users
  resources :courses
  root 'courses#index'
end
