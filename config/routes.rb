Rails.application.routes.draw do
  root "habits#tracker"

  get "tracking_points/new"
  get "tracking_points/create"
  get "tracking_points/edit"
  get "tracking_points/update"

  get "tracker", to: "habits#tracker", as: "habit_tracker"

  resources :habits do
    member do
      put "status", :update_status_on_date
      get "more_history"
    end
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
