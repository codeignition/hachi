Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, :controllers => {:confirmations => 'confirmations'}
  devise_scope :user do
    patch "/confirm" => "confirmations#confirm"
  end
  root 'static_pages#home'
end
