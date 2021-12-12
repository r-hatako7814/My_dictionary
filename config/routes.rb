Rails.application.routes.draw do

  post 'contacts/confirm' => 'customer/contacts#confirm'
  get 'contacts/confirm' => 'customer/contacts#confirm'
  post 'contacts/back' => 'customer/contacts#back'
  get 'contacts/back' => 'customer/contacts#back'
  get 'contacts/done' => 'customer/contacts#done'
  # 顧客用
  # URL /customers/sign_in ...
  root :to => "customer/homes#top"
  get "/about" => "customer/homes#about"

  get "/customers/:id/my_dictionary" => "customer/customers#show" ,as: "customers_my_dictionary"
  get "/customers/edit" => "customer/customers#edit"
  patch "/customers" => "customer/customers#update"
  get "/customers/unsubscribe" => "customer/customers#unsubscribe"
  patch "/customers/withdraw" => "customer/customers#withdraw"

  devise_for :customers,skip: [:passwords,], controllers: {
    omniauth_callbacks: 'customer/omniauth_callbacks',
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }

  get 'index_search' => 'customer/contributions#index_search'
  get 'show_search' => 'customer/customers#show_search'
  get 'increment_show_search' => 'customer/customers#increment_show_search'

  get 'autocomplete_index_search' => 'customer/contributions#autocomplete_index_search'

  scope module: :customer do
    resources :contacts, only: [:new,:create]
    resources :contributions, only: [:create,:index,:show,:edit,:update,:destroy] do
      resource :favorites, only: [:create,:destroy]
    end
  end



  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :customers,only:[:index,:show,:edit,:update]
    resources :genres,only:[:index,:create,:edit,:update,:destroy]
  end

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
