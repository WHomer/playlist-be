Rails.application.routes.draw do
  # root to: 'home#index'

  devise_for :users,
              path: '',
              path_names: {
                registration: 'sign_up'
              },
              controllers: {
                sessions: 'sessions',
                registrations: 'registrations'
              }

  namespace :api do
    namespace :v1 do
      resources :favorites, only: [:index, :show, :create, :destroy]
    end
  end
end
