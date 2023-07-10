Rails.application.routes.draw do
  

  # 社員用
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # 管理者用
  devise_for :admins,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  # 社員用

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    get '/index' => 'homes#index', as: 'index'
    get '/searchs' => 'searchs#search'
    resources :favorites, only: [:index]
    resources :comments, only: [:index]
    resources :products, only: [:new,:create,:show,:edit,:update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy, :show]
      member do
        get 'confirm'
        patch 'take_over'
      end
    end
    
    get '/new_products' => 'products#new_index'
    get '/used_products' => 'products#used_index'
    resources :tags, only: [:show]
    get 'users' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/products_index' => 'users#products_index'
    resources :notifications, only: [:index, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
  end
  
  # 管理者用

  namespace :admin do
    get '/' => 'homes#top'
    get '/result'  => 'homes#result'
    resources :departments, only: [:index,:show,:edit,:create,:update, :destroy]
    resources :products, only: [:index,:show,:edit,:update,:destroy] do
      collection do
        get 'search' => 'products#search'
      end
      resources :comments, only: [:destroy, :show]
    end
    resources :tags, only: [:index,:edit,:create,:update, :destroy]
    resources :users, only: [:index,:show,:edit,:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
