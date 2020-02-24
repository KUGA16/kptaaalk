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
  resources :group_users, only: [:create] do
    member do
      get 'new'
    end
  end
  #サイト退会ページ
  # get 'withdraw_top/:id' => 'users#withdraw_top' ,as: "user_withdrew"
  resources :groups,       only: [:show, :new, :create, :edit, :update, :destroy]

end
