Rails.application.routes.draw do

  namespace :admin do
    get 'homes/top'
  end
  namespace :admin do
    get 'orders/show'
  end
  namespace :public do
    get 'cart_items/index'
  end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  scope module: :public do
#homes
  root to: "homes#top"
  get "about" => "homes#about"

#customers
  get "customers/my_page" => "customers#show"
  get "customers/information/edit" => "customers#edit"
  patch "customers/information" => "customers#update"
  get "customers/unsubscribe" => "customers#unsubscribe"
  patch 'customers/withdraw' => 'customers#withdraw'

#items
  resources :items,only:[:index, :show]
#カート
  delete "cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all_cart_items"
  resources :cart_items ,only:[:index, :update, :destroy, :delete, :destroy_all, :create]

#order
  post "orders/comfirm" => "orders#comfirm"
  get "orders/complete" => "orders#complete"
  resources :orders,only:[:new, :index, :update, :destroy, :create, :index, :show]


 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

###
namespace :admin do
  root to: "homes#top"
  #get "sign_up" => "registrations#new"
#item
  resources :items,only:[:new, :index, :show, :create, :destroy ,:edit, :update]
#genre
  resources :genres,only:[:new, :index, :create, :destroy ,:edit,:update]
#customers
  resources :customers
#orders
  resources :orders,only:[:show, :update ]
end


end
