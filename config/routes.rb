Rails.application.routes.draw do
  
  resources :groups, defaults: {format: 'json'} do
    resources :contacts, defaults: {format: 'json'} do
      member do
        match '/delete/:attr_id/:attr_type' => 'contacts#delete_attribute', via: [:options, :post]
      end      
    end
  end

  namespace :admin, defaults: {format: 'json'} do
    resources :allowed_domains, only: [:index]
    match '/allowed_domains/save_domains' => 'allowed_domains#save_domains', via: [:options, :post] 
  end
  match '/is_admin' => 'application#is_admin', via: [:options, :get]
  match '/allowed_domains' => 'application#allowed_domains', via: [:options, :get]
  match '/auth/login' => 'authentication#authenticate', via: [:options, :post]
  match '/auth/signup' => 'authentication#signup', via: [:options, :post]
end
