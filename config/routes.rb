Rails.application.routes.draw do

  post "home/comments/:post_id", to: "home#comments", as: :comments

  get "home/search/", to: "home#search", :as => :post_search 
  devise_for :users
  get "home/read/:id", to: "home#read", :as => :post_read
  get "home/:tag/posts", to: "home#tag_search", :as => :tag_search
  get "home/category/:category_slug", to: "home#category_search", :as => :category_search
  
  namespace :api do
    get "posts", to: "posts#index"
    get "posts/:id", to: "posts#show"
    post "posts", to: "posts#create"   
    delete "posts/:id", to:"posts#destroy" 
  end  
  
  scope :admin do
    resources :posts
    resources :categories
    resources :tags
  end
  
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
