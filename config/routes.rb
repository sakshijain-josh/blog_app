Rails.application.routes.draw do
  resources :blogs do
    member do
      patch :publish
    end
    resources :comments
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
