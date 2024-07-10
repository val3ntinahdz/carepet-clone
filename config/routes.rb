Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  resources :pets do
    resources :vaccinations, only: %i[edit update]
    resources :conditions, only: %i[index new create edit update destroy]
    resources :allergies, only: %i[new create]
    resources :trainings, only: %i[new create]
    resources :nutritions, only: %i[index new create]
  end

  resources :conditions, except: %i[new create]
  resources :allergies, except: %i[new create]
  resources :trainings, except: %i[new create]
  resources :nutritions, except: %i[index new create]

  resources :veterinaries do
    resources :services, only: %i[new create]
  end

  resources :services, except: %i[new create] do
    resources :appointments, only: %i[new create]
  end

  resources :appointments, except: %i[new create]

  get 'profile', to: 'users#profile', as: :profile
  post 'mark_meal_as_completed', to: 'nutritions#mark_meal_as_completed', as: :mark_meal_as_completed

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
