Rails.application.routes.draw do
  get "home/index"
  root "home#index"
  resource :habit, only: [ :new, :create, :edit, :update, :destroy ]
  resources :records, only: [ :index, :create ]
  resources :habit_logs, only: [ :index ]
end
