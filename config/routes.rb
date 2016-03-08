Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: :index

  namespace :users do
    resource :profile, only: [:edit, :update], controller: :profile
    resources :courses
  end

  scope module: 'users' do
    resource :dashboard, only: :show
  end

  root 'courses#index'
end
