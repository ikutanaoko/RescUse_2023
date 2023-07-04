Rails.application.routes.draw do
  
  # 社員用
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    get '/index' => 'homes#index', as: 'index'
  end
  
  # 管理者用
  devise_for :admins,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    get '/' => 'home#top'
    get '/result'  => 'home#result'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
