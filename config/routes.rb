Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :answers, only:  %i[index create]
    resources :questions, only: %i[index show create]
    resources :question_tags, only: :create
    resources :tags, only: %i[index show create]
    resources :users, only: %i[index show create]

    get "/user_info" => "users#user_info"
  end
end
