Rails.application.routes.draw do
  #deviseを使用する際にURLとしてusersを含む
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
