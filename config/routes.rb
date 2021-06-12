Rails.application.routes.draw do

  root to: 'users#index'
  post  'users/create_account_link', to: 'users#create_account_link', as: 'stripe_express' # redirect to stripe
  post  'users/destroy', to: 'users#destroy', as: 'destroy' # destroy the browser session & stripe account

end
