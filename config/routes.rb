Storytime::Application.routes.draw do
  root :to => "story_cards#index"
  
  resources :users

  get "/signin" => "sessions#new", :as => "signin"
  delete '/signout' => "sessions#destroy", :as => "signout"
  post "/sessions" => "sessions#create"

  resources :story_cards do
    get "reply" => "story_cards#reply", :on => :member
    get "replies" => "story_cards#replies", :on => :member
    get 'vote/:value' => "story_cards#vote", :on => :member, :as => "vote"
  end
end
