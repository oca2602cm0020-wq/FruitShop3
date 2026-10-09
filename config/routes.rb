Rails.application.routes.draw do
  resources :customers
  resources :employees
  get "orders/new"
  get "mypage/show"
  # ユーザ認証
  devise_for :users

  # マイページ
  resources :mypage, only: [:show]

  # 商品登録
  resources :products

  # 商品登録
  #get 'products/new'
  #post 'products', to: 'products#create'  # 登録

  # 商品一覧
  #get 'products', to: 'products#index'

  # 商品詳細
  #get 'products/:id', to: 'products#show', as: 'product'

  # 商品編集
  #get 'products/:id/edit', to: 'products#edit', as: 'edit_product'
  #patch 'products/:id', to: 'products#update' # 編集

  # 商品削除
  #delete 'products/:id', to: 'products#destroy', as: 'destroy_product'

  # 商品関係

  # 注文関係
  resources :orders, only: [:index, :new, :create] do
    collection do
      post :confirm  # 注文確認
    end

    member do
      get :complete  # 注文完了
    end
  end
  
  # トップページ
  root to: "homes#top"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :carts, only: [:show, :index] do
  # セッションカートに商品を追加、数量を更新、商品を削除するアクション
    collection do
      post :add_product  # カートに商品を追加
    end
    member do
      delete :remove_item  # カートから商品を削除
      post :update_quantity  # カート内の商品数を変更
    end
  end
  # ユーザーのカート内の商品操作
  resources :cart_items, only: [:create, :update, :destroy]
end