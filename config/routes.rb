Rails.application.routes.draw do

  get "home/search/", to: "home#search", :as => :post_search 
  devise_for :users
  get "home/read/:id", to: "home#read", :as => :post_read
  get "home/:tag/posts", to: "home#tag_search", :as => :tag_search
  get "home/category/:category_slug", to: "home#category_search", :as => :category_search
  resources :posts
  resources :categories
  resources :tags
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #contollrename/actionname
  # in root route contollrename#actionname
  # root to: 'home#index' # or
  root "home#index"
  get 'home/ok'
  get 'home/index'
  get 'home/about', as: :about 
  get 'home/contact', as: :contact
end
