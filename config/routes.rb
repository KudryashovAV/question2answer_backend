Rails.application.routes.draw do
  root 'pages#home'

  namespace :api do
    resources :answers, only:  %i[index create]
    resources :comments, only:  %i[index create]
    resources :questions, only: %i[index show create]
    resources :question_tags, only: :create
    resources :tags, only: %i[index show create]
    resources :users, only: %i[index show create update]

    get "/user_info" => "users#user_info"
  end
end
