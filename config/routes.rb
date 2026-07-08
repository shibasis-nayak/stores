Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :products do
    member do
      patch :upload_images
    end

    resources :ratings, only: [:create]
  end

  resources :categories

  root "welcome#index"
end