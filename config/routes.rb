Rails.application.routes.draw do
  get "home/index"
  root "home#index"
  get "terms", to: "static_pages#terms"
  get "privacy", to: "static_pages#privacy"
  resource :habit, only: [ :new, :create, :edit, :update, :destroy ]
  resources :records, only: [ :index, :create ]
  resources :habit_logs, only: [ :index ]
end
