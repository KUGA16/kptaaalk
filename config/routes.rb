Rails.application.routes.draw do
  get 'group_users/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #deviseを使用する際にURLとしてusersを含む
  devise_for :users

  root 'homes#top'
  get 'about' => 'homes#about', as: 'about'
  resources :users, only: [:show, :edit, :update, :destroy]do
    collection do
      get 'result' #検索結果表示ページ
    end
  end
  #サイト退会ページ
  get 'withdraw_top/:id' => 'users#withdraw_top' ,as: "user_withdrew"
  resources :groups, only: [:show, :new, :create, :edit, :update, :destroy]

end
