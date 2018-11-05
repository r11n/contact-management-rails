Rails.application.routes.draw do
  
  resources :groups, defaults: {format: 'json'} do
    match 'toggle_status' => 'groups', via: [:options, :post]
    resources :contacts, defaults: {format: 'json'}
  end

  namespace :admin, defaults: {format: 'json'} do
    resources :allowed_domains, only: [:index] do
      match 'save_domains' => 'allowed_domains#save_domains', via: [:options, :post] 
    end
  end
  match '/is_admin' => 'application#is_admin', via: [:options, :get]
  match '/allowed_domains' => 'application#allowed_domains', via: [:options, :post]
  match '/auth/login' => 'authentication#authenticate', via: [:options, :post]
  match '/auth/signup' => 'authentication#signup', via: [:options, :post]
end
