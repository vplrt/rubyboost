Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: [:index, :show] do
    resource :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
  end

  namespace :users do
    resource :profile, only: [:edit, :update], controller: :profile
    resources :courses do
      resources :lessons, only: [:new, :create, :destroy]
    end
  end

  scope module: 'users' do
    resource :dashboard, only: :show
  end

  root 'courses#index'
end
