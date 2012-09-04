Oa2c::Engine.routes.draw do
  post 'authorizations/create' => 'authorizations#create', :as => 'authorizations'
  match 'authorize', to: 'authorizations#new'
  match 'token', to: proc {|env| Oa2c::AuthorizationsController.new.send(:token_endpoint).call(env) }
end
