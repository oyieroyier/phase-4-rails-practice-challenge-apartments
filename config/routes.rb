Rails.application.routes.draw do
  resources :leases, only: %i[create destroy]
  resources :tenants, only: %i[create show index update destroy]
  resources :apartments, only: %i[index show create update destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
