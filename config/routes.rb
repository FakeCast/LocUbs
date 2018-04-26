Rails.application.routes.draw do
  post '/show/', to: 'api/v1/unidades#show', as: 'show'
  get '/refresh/', to: 'api/v1/unidades#refresh', as: 'refresh'
end
