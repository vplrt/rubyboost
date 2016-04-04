require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :courses, only: :index do
        scope 'user', module: 'user' do
          resource :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
        end
      end
      resources :auth_tokens, only: :create
      resources :registrations, only: :create

      scope 'user/self', as: 'user', module: 'user' do
        resources :courses, only: :index, controller: :participated_courses
      end

      scope 'user/:id', as: 'authored', module: 'user' do
        resources :courses, only: :index, controller: :authored_courses
      end
    end
  end

  resources :courses, only: [:index, :show] do
    resource :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
    resources :lessons, except: [:edit, :update]
  end

  namespace :users do
    resource :profile, only: [:edit, :update], controller: :profile
    resources :courses
    resources :activities, only: :index
  end

  scope module: 'users' do
    resource :dashboard, only: :show

    scope '/lessons/:lesson_id' do
      resources :homeworks, only: [:show, :index, :create] do
        member do
          put 'approve', to: 'homeworks#approve'
          put 'reject', to: 'homeworks#reject'
        end
      end
    end

    resources :lessons, only: [] do
      resources :comments, only: [:create, :destroy]
    end

    resources :homeworks, only: [] do
      resources :comments, only: [:create, :destroy]
    end
  end

  post '/courses/:course_id/participants/:user_id/expel', to: 'course_expulsions#create', as: :expel_course_participant

  root 'courses#index'
end
