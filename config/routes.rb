Rails.application.routes.draw do

	root 'log_books#index'

	resources :log_books

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
