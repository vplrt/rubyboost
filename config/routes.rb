require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  mount Sidekiq::Web, at: '/sidekiq'

  resources :courses, only: [:index, :show] do
    resource :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
    resources :lessons, except: [:edit, :update]
  end

  namespace :users do
    resource :profile, only: [:edit, :update], controller: :profile
    resources :courses
  end

  scope module: 'users' do
    resource :dashboard, only: :show

    scope '/lessons/:lesson_id' do
      resources :homeworks
    end
  end

  post '/courses/:course_id/participants/:user_id/expel', to: 'course_expulsions#create', as: :expel_course_participant

  root 'courses#index'
end
