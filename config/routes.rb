Rails.application.routes.draw do
  # Route for creating new links and listing all links
  resources :links, only: [:index, :create, :show]

  # Route for redirecting short URLs to original URLs
  get '/:short_url', to: 'links#redirect', as: :short

  # Root path route
  root "links#index"
end
