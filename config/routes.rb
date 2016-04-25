Rails.application.routes.draw do
  devise_for :users

  resources :notes do
    collection { post :sort}
  end

  authenticated :user do
    root 'notes#index', as: "authenticated_root"
  end

  root 'home#index'

end
