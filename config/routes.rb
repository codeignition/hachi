Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, :controllers => {:confirmations => 'confirmations', registrations: 'registrations'}
  devise_scope :user do
    patch "/confirm" => "confirmations#confirm"
    get '/users/sign_up' => 'registrations#new'
  end
  root 'static_pages#home'
  get '/ldap_configurations/new' => 'ldap_configurations#new', as: 'new_ldap_configuration'
  post '/ldap_configurations/' => 'ldap_configurations#create'
end
