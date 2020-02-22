Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #deviseを使用する際にURLとしてusersを含む
  devise_for :users

  root 'homes#top'
  get 'about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :edit, :update, :destroy]do
    collection do
      get 'result'
    end
  end
  
end
