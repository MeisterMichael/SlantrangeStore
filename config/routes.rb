Rails.application.routes.draw do

	devise_scope :user do
		get '/forgot' => 'passwords#new', as: 'forgot'
		get '/login' => 'sessions#new', as: 'login'
		get '/logout' => 'sessions#destroy', as: 'logout'
		get '/register' => 'registrations#new', as: 'register'
	end

	# devise_for :users, :controllers => { :omniauth_callbacks => 'oauth', :registrations => 'registrations', :sessions => 'sessions', :passwords => 'passwords' }

	mount SwellEcom::Engine, :at => '/'
	mount SwellMedia::Engine, :at => '/'

end
