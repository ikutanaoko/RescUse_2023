Rails.application.routes.draw do
  
  # 社員用
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_scope :user do
  post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
end

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
        get 'reference'
        patch 'update_status'
      end
    end
    
    get '/new_products' => 'products#new_index'
    get '/used_products' => 'products#used_index'
    resource :tags, only: [:show]
    get 'users' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/products_index' => 'users#products_index'
    resources :inquiries, only: [:new]
    post 'inquiry/completion' => 'inquiries#completion'
    resources :notifications, only: [:index, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end

  end
  
  # 管理者用

  namespace :admin do
    get '/' => 'homes#top'
    resources :inquiries, only: [:update]
    resources :departments, only: [:index,:show,:edit,:create,:update, :destroy]
    resources :products, only: [:index,:show,:edit,:update,:destroy] do
      collection do
        get 'search' => 'products#search'
      end
      resources :comments, only: [:destroy]
    end
    resources :tags, only: [:index,:edit,:create,:update, :destroy]
    resources :users, only: [:index,:show,:edit,:update] do
        collection do
      get 'search' => 'users#search'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
