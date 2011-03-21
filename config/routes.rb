Gprofiles::Application.routes.draw do
  resources :profiles do | profile |
    resources :nodes
  end

  root :to => 'profiles#index'
end
