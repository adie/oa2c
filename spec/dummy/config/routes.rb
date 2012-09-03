Dummy::Application.routes.draw do
  mount Oa2c::Engine => "/oauth2"
end
