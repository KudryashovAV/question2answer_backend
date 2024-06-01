Rails.application.routes.draw do
  devise_for :admin_users
  root "admin/home#index"

  namespace :api do
    resources :answers, only:  %i[index create]
    resources :comments, only:  %i[index create]
    resources :questions, only: %i[index show create]
    resources :question_tags, only: :create
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
