Rails.application.routes.draw do

  resources :users

	root "static_pages#home"
	get '/ayuda', 					to: 'static_pages#help'
	get '/quienes_somos', 	to: 'static_pages#about'
	get '/contacto',	 			to: 'static_pages#contact'

  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end
