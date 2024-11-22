Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get 'dashboard', to: 'dashboard#dashboard', as: :dashboard
  resources :pets do
    resources :vaccinations, only: %i[new create]
    resources :conditions, only: %i[new create]
    resources :allergies, only: %i[new create]
    resources :trainings, only: %i[index new create]
    resources :nutritions, only: %i[index new create]
  end

  resources :vaccinations, only: %i[show edit update destroy]
  resources :conditions, only: %i[show edit update destroy]
  resources :allergies, only: %i[show edit update destroy]

  resources :vaccines, except: %i[new create]
  resources :conditions, except: %i[new create]
  resources :allergens, except: %i[new create]
  resources :trainings, except: %i[index new create]
  resources :nutritions, except: %i[index new create]

  resources :veterinaries do
    resources :services, only: %i[new create]
  end

  resources :services, except: %i[new create] do
    resources :appointments, only: %i[new create]
  end

  resources :appointments, except: %i[new create] do
    member do
      patch 'update_status'
    end
  end

  get 'profile', to: 'users#profile', as: :profile
  post 'mark_meal_as_completed', to: 'nutritions#mark_meal_as_completed', as: :mark_meal_as_completed
  post 'mark_training_as_completed', to: 'trainings#mark_training_as_completed', as: :mark_training_as_completed

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
