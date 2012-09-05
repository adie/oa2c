Dummy::Application.routes.draw do
  mount Oa2c::Engine => "/oauth2"
  devise_for :user
  match 'callback' => 'application#ok'
  root :to => 'application#ok'
end
