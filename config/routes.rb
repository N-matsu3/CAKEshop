Rails.application.routes.draw do
#homes
root to: "homes#top"
get "/about" => "homes#about"

  #devise_for :admins
  #devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
namespace :admin do
#item
  resources :items, only:[:new, :index, :show, :create, :destroy ,:edit]
#genre
  resources :genres,only:[:new, :index, :create, :destroy ,:edit,:update]

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
