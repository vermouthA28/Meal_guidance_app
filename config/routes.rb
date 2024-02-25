Rails.application.routes.draw do


# ゲストユーザー用
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # ユーザー用
# URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者（栄養士）用
# URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}



#管理者側（栄養士）
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update] do
      resources :todos, only: [:new, :create, :index, :destroy, :edit, :update]
      resources :posts, only: [:index, :show] do
        resources :comments, only: [:create, :destroy]
      end
    end
    resources :chats, only: [:show, :create, :destroy]
  end


  namespace :admin do
    root to: 'homes#top'
  end


#ユーザー側
  scope module: :public do
    resources :posts, only: [:new, :create, :edit, :update, :destroy, :index, :show] do
      collection do
        post 'checked', to: 'posts#checked'
        post '/todos/count', to: 'todos#count'
      end
    end

    get 'users/confirm_withdraw' => 'users#confirm_withdraw'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:edit, :update, :show]
    resources :chats, only: [:show, :create, :destroy]

    root to: 'homes#top'
    get "home/about"=>"homes#about"
    resources :notifications, only: :update
  end

end

