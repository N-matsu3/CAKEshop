Rails.application.routes.draw do
#homes
root to: "homes#top"
get "/about" => "homes#about"

  #devise_for :admins
  #devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

#item
get '/admin/items' => 'admin/items#index'
resources :items, only:[:new, :index, :show, :create, :destroy ,:edit]
get '/admin/items/new' => 'admin/items#new'

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
