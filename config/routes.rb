Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  resources :blogs do
    collection do
      get :drafts
    end
    member do
      patch :publish
    end
    resources :comments
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
