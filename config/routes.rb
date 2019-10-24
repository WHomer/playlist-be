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
      resources :favorites, except: [:new, :edit]
      resources :playlists, only: :index
    end
  end
end
