Rails.application.routes.draw do
  # Root path route
  root "links#index"

  # Routes for creating new links and listing all links
  resources :links, only: [:index, :create, :show, :destroy]

  # Route for redirecting short URLs to original URLs
  get '/:short_url', to: 'links#redirect', as: :short, constraints: { short_url: /.*/ }
end