Rails.application.routes.draw do

  resources :users
  resources :account_activations, only: [:edit]
	resources :buy_notifications, only: [:new, :create, :index, :show, :destroy]
	resources :password_resets, only: [:new, :create, :edit, :update]
  resources :posts, only: [:show, :index, :create, :destroy]
  resources :post_reports, only:[:show, :index, :new, :create, :destroy]
  resources :comments, only: [:create]

  resources :conversations do
    resources :messages
  end

	root "static_pages#home"
	get '/help',       to: 'static_pages#help'
	get '/about',      to: 'static_pages#about'
  get '/impact',     to: 'static_pages#impact'
  get '/partners',   to: 'static_pages#partners'
  get '/terms',      to: 'static_pages#terms'
  
  get   '/contact',    to: 'messages#new'
  post  '/contact',    to: 'messages#create'

  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end
