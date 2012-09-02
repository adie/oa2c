Oa2c::Engine.routes.draw do
  post 'authorizations/create'
  match 'authorize', to: 'authorizations#new'
  match 'token', to: proc {|env| Auth::AuthorizationsController.new.send(:token_endpoint).call(env) }
end
