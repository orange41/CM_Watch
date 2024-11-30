# config/routes.rb
Rails.application.routes.draw do
  devise_for :staffs
  
  root 'homes#index'
  get 'staff_login', to: 'homes#staff_login'
  get 'admin_login', to: 'homes#admin_login'
  get 'staff_dashboard', to: 'staffs#show'
  get 'admin_dashboard', to: 'admin_panel/dashboards#show', as: 'admin_dashboard'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  # devise_for :staffs, controllers: {
  #   sessions: 'staffs/sessions',
  #   passwords: 'staffs/passwords'
  # }, skip: [:registrations]

  devise_scope :staff do
    get 'custom_staff_login', to: 'staffs/sessions#new', as: :new_custom_staff_session
    post 'custom_staff_login', to: 'staffs/sessions#create', as: :custom_staff_session
    delete 'custom_staff_logout', to: 'staffs/sessions#destroy', as: :destroy_custom_staff_session

    get 'staffs/password/edit', to: 'staffs/passwords#edit', as: :edit_custom_staff_password
    put 'staffs/password', to: 'staffs/passwords#update', as: :custom_staff_password
  end

  devise_scope :admin do
    get 'custom_admin_login', to: 'admins/sessions#new', as: :new_custom_admin_session
    post 'custom_admin_login', to: 'admins/sessions#create', as: :custom_admin_session
    delete 'custom_admin_logout', to: 'admins/sessions#destroy', as: :destroy_custom_admin_session
  end

  resources :staffs, only: [:show, :edit, :update] do
    resources :incidents, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :edit, :update, :destroy]
    end
  end

  namespace :admin_panel do
    get 'dashboard', to: 'dashboards#show'
    resources :staffs, only: [:index, :new, :create, :destroy]
    resources :incidents do
      resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
    end
    resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
