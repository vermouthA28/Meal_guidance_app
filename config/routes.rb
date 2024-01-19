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
  end


  namespace :admin do
    root to: 'homes#top'
  end


#ユーザー側
  scope module: :public do
    resources :posts, only: [:new, :create, :edit, :update, :destroy, :index, :show] do
      collection do
        post 'checked', to: 'posts#checked'
        get 'count_todos', to: 'posts#count_todos'
      end
    end
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
