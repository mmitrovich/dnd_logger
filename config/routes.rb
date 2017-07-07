Rails.application.routes.draw do


  get 'tags' => 'tags#index'

	root 'log_books#index'

	resources :log_books
	resources :entries



	get 'access/login'
	post 'access/attempt_login'
	get 'access/logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
