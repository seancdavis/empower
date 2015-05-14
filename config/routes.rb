Empower::Engine.routes.draw do

  get 'users/oauth/finish' => 'users#edit', :as => :finish_signup
  patch 'users/oauth/finish' => 'users#update', :as => :complete_signup

end
