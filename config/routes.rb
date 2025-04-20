# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :employment_histories
  resources :documents
  resources :applicants
  resources :applications, controller: 'applications' do
    collection do
      # New application wizard steps
      get :new_loan_details
      post :create_loan_details
      get :new_applicants
      post :create_applicants
      get :new_properties
      post :create_properties
      get :new_assets
      post :create_assets
      get :new_liabilities
      post :create_liabilities
      get :new_documents
      post :create_documents
      get :new_declaration
      post :create_declaration
    end
    
    member do
      delete :remove_document
      # Sidebar wizard steps for editing
      get :properties_step1
      patch :properties_step1
      get :properties_step2
      patch :properties_step2
      get :assets_step1
      patch :assets_step1
      get :assets_step2
      patch :assets_step2
      get :liabilities_step1
      patch :liabilities_step1
      get :applicants_step1
      patch :applicants_step1
      get :documents_step1
      patch :documents_step1
      get :declaration_step1
      patch :declaration_step1
    end
  end

  # Dashboard route
  get '/dashboard', to: 'dashboard#index', as: :dashboard

  # Authenticated users see dashboard, others see marketing homepage
  authenticated :user do
    root to: 'dashboard#index', as: :authenticated_root
  end
  unauthenticated do
    root to: 'static#index', as: :unauthenticated_root
  end

  # Redirect legacy index route to dashboard
  get '/applications', to: redirect('/dashboard')
  get '/finance_applications', to: redirect('/dashboard')

  resources :properties
  draw :accounts
  draw :api
  draw :billing
  draw :hotwire_native
  draw :users
  draw :dev if Rails.env.local?

  authenticated :user, lambda { |u| u.admin? } do
    draw :madmin
  end

  resources :announcements, only: [:index, :show]

  namespace :action_text do
    resources :embeds, only: [:create], constraints: {id: /[^\/]+/} do
      collection do
        get :patterns
      end
    end
  end

  scope controller: :static do
    get :about
    get :terms
    get :privacy
    get :pricing
    get :reset_app
  end

  match "/404", via: :all, to: "errors#not_found"
  match "/500", via: :all, to: "errors#internal_server_error"

  authenticated :user do
    root to: "dashboard#show", as: :user_root
    # Alternate route to use if logged in users should still see public root
    # get "/dashboard", to: "dashboard#show", as: :user_root
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Public marketing homepage
  root to: "static#index"
end
