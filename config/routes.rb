Rails.application.routes.draw do
  
  resources :groups, defaults: {format: 'json'}
  resources :contacts, defaults: {format: 'json'}

  namespace :admin, defaults: {format: 'json'} do
    resources :allowed_domains, only: [:index] do
      match 'save_domains' => 'allowed_domains#save_domains', via: [:options, :post] 
    end
  end
  match '/auth/login' => 'authentication#authenticate', via: [:options, :post]
  match '/auth/signup' => 'authentication#signup', via: [:options, :post]
end
