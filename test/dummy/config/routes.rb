Rails.application.routes.draw do

  match ':controller(/:action(/:id))(.:format)', :via => [:get,:post]
  root :to => 'sessions#login'

  match "signup", :to => "users#new", :via => [:get], :as => 'signup'
  match "login", :to => "sessions#login", :via => [:get], :as => 'login'
  match "logout", :to => "sessions#logout", :via => [:get], :as => 'logout'
  match "home", :to => "sessions#home", :via => [:get], :as => 'home'
  match "profile", :to => "sessions#profile", :via => [:get], :as => 'profile'
  match "setting", :to => "sessions#setting", :via => [:get], :as => 'setting'

  mount DiscourseMountableSso::Engine => "/discourse_mountable_sso"
end
