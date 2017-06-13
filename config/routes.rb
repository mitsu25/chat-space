Rails.application.routes.draw do
  root       "messages#index"
  devise_for :users
  resources  :users,    only: [:edit,:update,:index]
  resources  :groups, except: [:index, :destroy] do
    resources  :messages, only: [:index, :create]
  end
end
