Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/favorites/:id', to: 'favorites#show'
    end
  end
end
