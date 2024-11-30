Rails.application.routes.draw do
  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions',
    registrations: 'staffs/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  root 'homes#index'

  namespace :admin_panel do
    get 'dashboard', to: 'dashboards#show', as: 'admin_dashboard'
    get 'dashboard/edit', to: 'dashboards#edit', as: 'edit_admin_dashboard'
    patch 'dashboard', to: 'dashboards#update', as: 'admin_dashboard_update'
    resources :staffs, only: [:index, :new, :create, :destroy]
    resources :incidents, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :comments, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  resources :staffs, only: [:show, :edit, :update] do
    resources :incidents, only: [:index, :show, :new, :create, :edit, :update, :destroy], module: :staffs
  end

  get 'staff_dashboard', to: 'staffs#show', as: 'staff_dashboard'
end
