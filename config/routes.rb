require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  devise_for :admin_users
  root "admin/actions#index"

  namespace :api do
    resources :answers, only:  %i[index create destroy]
    resources :comments, only:  %i[index create destroy]
    resources :questions
    resources :question_tags, only: :create
    resources :admin, only: %i[index update destroy]
    resources :tags, only: %i[index show create]
    resources :users, only: %i[index show create update]

    get "/user_info" => "users#user_info"
  end

  namespace :admin do
    resources :questions, only: %i[index show]
    resources :actions, only: %i[index show create]
    resources :users, only: %i[index show]
    resources :comments, only: %i[index show]
    resources :answers, only: %i[index show]
  end
end
