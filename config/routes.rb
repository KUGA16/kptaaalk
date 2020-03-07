Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #deviseを使用する際にURLとしてusersを含む
  devise_for :users

  root 'homes#top'
  get 'about' => 'homes#about', as: 'about'

  resources :users,          only: [:show, :edit, :update, :destroy] do
    resource :relationships, only: [:create,:destroy]
    get :follows,   on: :member #フォロー一覧
    get :followers, on: :member #フォロワー一覧
    member do
      get 'withdraw' #サイト退会ページ
    end
    collection do
      get 'result' #検索結果表示ページ
    end
  end

  resources :groups,       only: [:show, :new, :create, :edit, :update, :destroy] do
    resource :group_users, only: [:new, :create, :update, :destroy]
    resources :comments,   only: [:index, :new, :create, :edit, :update, :destroy]do
      resource :rights,    only: [:create, :destroy]
    end
  end

end
