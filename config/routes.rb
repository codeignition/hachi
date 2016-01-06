Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  root 'static_pages#home'
end
