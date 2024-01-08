Rails.application.routes.draw do
  
#管理者側（栄養士）
  namespace :admin do
    resources :todos, only: [:new, :create, :destroy, :edit, :update]
  end
  
  namespace :admin do
     resources :comments, only: [:create, :destroy, :edit, :update]
  end
  
  namespace :admin do
     resources :posts, only: [:index, :show]
  end
  
  namespace :admin do
    root to: 'homes#top'
  end

  
#ユーザー側
  scope module: :public do
    resources :posts, only: [:new, :create, :edit, :update, :destroy, :index, :show]
  end
  
  scope module: :public do
    get 'users/confirm_withdraw' => 'users#confirm_withdraw'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:edit, :update, :show]
  end
  
  scope module: :public do
    root to: 'homes#top'
    get "home/about"=>"homes#about"
  end

  
# 管理者（栄養士）用
# URL /admin/sign_in ...
  devise_for :dieticians, controllers: {
  sessions: "admin/sessions"
}
  
# ユーザー用
# URL /customers/sign_in ...
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
