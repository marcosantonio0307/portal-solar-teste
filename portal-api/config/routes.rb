# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope :api do
    scope :v1 do
      mount_devise_token_auth_for 'Customer', at: 'customer'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :customers, only: %i[show update]

      resources :simulations, only: %i[create]
    end
  end
end
