Bloccit::Application.routes.draw do

  devise_for :users

  resources :topics do
    resource :posts, except: [:index]
  end

match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end