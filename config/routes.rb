Rails.application.routes.draw do
  devise_for :users

  resources :courses, only: :index

  namespace :users do
    resources :courses
  end

  scope module: 'users' do
    resource :dashboard, only: :show
  end

  root 'courses#index'
end
