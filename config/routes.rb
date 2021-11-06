Rails.application.routes.draw do


  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }
  root :to => "customer/homes#top"
  get "/about" => "customer/homes#about"

  get "/customers/my_dictionary" => "customer/customers#show"
  get "/customers/edit" => "customer/customers#edit"
  patch "/customers" => "customer/customers#update"
  get "/customers/unsubscribe" => "customer/customers#unsubscribe"
  patch "/customers/withdraw" => "customer/customers#withdraw"

  get  'search' => 'searches#search'

  scope module: :customer do
    resources :contributions, only: [:create,:index,:show,:edit,:update,:destroy] do
      resource :favorites, only: [:create,:destroy]
    end
  end
  # ↓これを定義
  # post "/contributions/create" => "customer/contributions#create"
  # get "/contributions/index" => "customer/contributions#index"
  # get "/contributions/show" => "customer/contributions#show"
  # get "/contributions/edit" => "customer/contributions#edit"
  # patch "/contributions/update" => "customer/contributions#update"
  # delete "/contributions/destroy" => "customer/contributions#destroy"



  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :admin do
    resources :customers,only:[:index,:show,:edit,:update]
    resources :genres,only:[:index,:create,:edit,:update]
  end

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
