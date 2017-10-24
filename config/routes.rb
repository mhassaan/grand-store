Rails.application.routes.draw do

  devise_for :users,controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'welcome#index'
	get 'dashboard', to: 'dashboard#index'
	# resources: :variants
	# resources: :properties
	scope module: 'admin' do
		#resources :variants
		resources :options
		resources :properties
		resources :categories do
				get 'get_root_node'
		end
		resources :products do
			get 'get_product_options_tree'
			get 'get_option_values'
		end
		post 'add_node_to_tree' => 'categories#add_node_to_tree'
		post 'update_node_text' => 'categories#update_node_text'
		#get 'build_tree' => 'categories#build_tree'
		#get 'test' => 'categories#test'
	end
end
