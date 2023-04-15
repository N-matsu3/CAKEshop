Rails.application.routes.draw do

  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
#homes
  root to: "public/homes#top"
  get "about" => "public/homes#about"

###
#customers
  resources :customers
  get "/my_page" => "public/customers#show"


  #devise_for :admins
  #devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

###
namespace :admin do
#item
  resources :items,only:[:new, :index, :show, :create, :destroy ,:edit, :update]
#genre
  resources :genres,only:[:new, :index, :create, :destroy ,:edit,:update]
#customers
  resources :customers
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

end
