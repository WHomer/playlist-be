Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :favorites, only: [:show, :create, :destroy]
    end
  end
end
