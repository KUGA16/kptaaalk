Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #deviseを使用する際にURLとしてusersを含む
  devise_for :users

  root 'homes#top'
  get 'about' => 'homes#about', as: 'about'
  resources :users,       only: [:show, :edit, :update, :destroy] do
    member do
      get 'withdraw_top' #サイト退会ページ
    end
    collection do
      get 'result' #検索結果表示ページ
    end
  end
  resources :groups,       only: [:show, :new, :create, :edit, :update, :destroy] do
    resource :members,     only: [:new, :create]
  end
  resources :comments,     only: [:index, :new, :create, :edit, :update, :destroy]
end
