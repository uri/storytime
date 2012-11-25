Storytime::Application.routes.draw do
  root :to => "story_cards#index"
  resources :story_cards do
    get "reply", :on => :member
  end
end
