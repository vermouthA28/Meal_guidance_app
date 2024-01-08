Rails.application.routes.draw do
  
  namespace :admin do
    get 'todos/new'
    get 'todos/edit'
  end
  namespace :admin do
    get 'comments/edit'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/confirm_withdraw'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
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
  
  
    root to: 'homes#top'
end
