Rails.application.routes.draw do

  root   'sessions#new'

  get    '/signup',  to: 'users#new'
  get    '/profile', to: 'users#show'
  get    '/profile/edit', to: 'users#edit'
  get    '/matching',to: 'matchings#index'
  get    '/matching/change',   to: 'matchings#change'
  get    '/contact', to: 'static_pages#contact'
  get    '/login',   to: 'sessions#new'

  post   '/signup',  to: 'users#create'
  post   '/user/create',  to: 'users#create'
  post   '/matching',to: 'matchings#update'
  post   '/contact', to: 'static_pages#send_mail'
  post   '/login',   to: 'sessions#create'

  patch  '/user/update',  to: 'users#update'

  delete '/user/delete',   to: 'users#destroy'
  delete '/logout',        to: 'sessions#destroy'

  resources :password_resets, only: [:new, :create, :edit, :update]

  # routesに記載のないurlへのアクセスを全てリダイレクト
  get "*path" => redirect("/")

end