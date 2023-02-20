Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :categories
      resources :users do
        post 'facts/create-many', to: 'facts#create_many'
        resources :facts         
      end
      post '/auth/login', to: 'authentication#login'

    end
  end
  
end
