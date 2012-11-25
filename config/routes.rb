Storytime::Application.routes.draw do
  root :to => "story_cards#index"
  resources :story_cards do
    get "reply" => "story_cards#reply", :on => :member
    get 'vote/:value' => "story_cards#vote", :on => :member
  end
end
