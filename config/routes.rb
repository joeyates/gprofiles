Gprofiles::Application.routes.draw do

  resources :profiles do
    resources :nodes
  end

  root :to => 'profiles#index'
end
