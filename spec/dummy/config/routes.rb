Dummy::Application.routes.draw do
  mount Oa2c::Engine => "/oauth2"
  devise_for :user
  match 'callback' => 'application#ok'
  root :to => 'application#ok'
  match 'protected' => 'application#protected'
  match 'protected_client' => 'application#protected_client'
  match 'protected_user' => 'application#protected_user'
end
