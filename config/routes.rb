Rails.application.routes.draw do
  root       "messages#index"
  devise_for :users

  resources  :users,    only: [:edit, :update] do
    collection do
      get 'search'
    end
  end

  resources  :groups, except: [:index, :destroy] do
    resources  :messages, only: [:index, :create] do
      collection do
        get 'reload'
      end
    end
  end

end
