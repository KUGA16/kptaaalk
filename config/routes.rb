Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #homes
  root 'homes#top'

  #users
  #deviseを使用する際にURLとしてusersを含む
  devise_for :users
  resources :users, only: [:show, :edit, :update], param: :user_id
  resources :users, only: [] do
    resource :relationships, only: [:create, :destroy]
    get 'friends' #フォロー、フォロワー一覧
  end

  #groups
  resources :groups, only: [:show, :new, :create, :edit, :update, :destroy], param: :group_id
  resources :groups, only: [] do
    #group_users
    resource :group_users, only: [:new, :create, :update, :destroy]
    resources :comments,   only: [:index, :new, :create, :edit, :update, :destroy], param: :comment_id
    resources :comments,   only: [] do
      resource :rights,    only: [:create, :destroy]
    end
  end

  #commnets > ドラッグ&ドロップ
  post 'place_status_update' => 'comments#place_status_update'

  #search
  get 'search' => 'search#users', as: 'search_users'

end
