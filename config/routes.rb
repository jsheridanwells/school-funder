Rails.application.routes.draw do
  get 'users/new'

  root 'application#home'
end
