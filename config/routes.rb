Rails.application.routes.draw do
  root       "messages#index"
  devise_for :users
  resources  :users,    only: [:edit,:update]
  resources  :groups, except: [:index, :destroy] do
    resources  :messages, only: [:index, :create]
  end
end
