require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == Settings.sidekiq.username && password == Settings.sidekiq.password
  end if Rails.env.production?
  mount Sidekiq::Web, at: '/sidekiq'

  concern :activeable do
    post :toggle_is_active, on: :member
  end

  # Admins
  devise_for :admins, controllers: { sessions: 'hq/sessions', registrations: 'hq/registrations', passwords: 'hq/passwords' }, path: 'hq',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret',  confirmation: 'verification' }
  as :admin do
    get 'hq/edit' => 'hq/registrations#edit', as: 'edit_admin_registration'
    put 'hq' => 'hq/registrations#update', as: 'admin_registration'
  end
  namespace :hq do
    root to: 'dashboard#index'
    resources :dashboard, only: [:index]
    resources :admins, concerns: [:activeable]
    resources :users, concerns: [:activeable]
    resources :countries
    resources :cities
    resources :audits, only: [:index, :show]
    resources :places, concerns: [:activeable] do
      resources :images
    end
    resources :interests
    resources :categories
    resources :comments, only: [:index, :destroy]
  end
  # Users
  devise_for :users, controllers: { sessions: 'user/sessions', registrations: 'user/registrations', passwords: 'user/passwords', :omniauth_callbacks => "user/omniauth_callbacks" }, path: 'user',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret',  confirmation: 'verification' }
  as :user do
    get 'user/edit' => 'user/registrations#edit', as: 'edit_user_profile_registration'
    put 'user' => 'user/registrations#update', as: 'user_profile_registration'
  end
  namespace :user do
    root to: 'dashboard#index'
    resources :dashboard, only: [:index]
    resources :profile, only: [:show, :edit, :update]
    # resources :interests # come back later this
  end
  resources :users, only: [:index] do
    resources :comments, only: [:create, :destroy]
  end

  # Common pages
  root to: 'welcome#index'

  resources :places do
    resources :comments, only: [:create, :destroy]
    put '' => 'places#visit', as: 'visit'
  end

  resources :categories, only: [:index]

  get 'search' => 'places#search', as: 'search'
  if Rails.env.production? or Rails.env.staging?
    match '*unmatched_route', to: 'application#page_not_found', via: :all
  end

end
