Rails.application.routes.draw do
  root 'homes#top'
  get 'staff_login', to: 'homes#staff_login'
  get 'admin_login', to: 'homes#admin_login'
  get 'staff_dashboard', to: 'staffs#show'
  get 'admin_dashboard', to: 'admin_panel/dashboards#show', as: 'admin_dashboard'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions',
    passwords: 'staffs/passwords'
  }

  resources :staffs, only: [:show, :edit, :update] do
    resources :incidents, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :edit, :update, :destroy]
    end
  end

  namespace :admin_panel do
    get 'dashboard', to: 'dashboards#show'
    resources :staffs
    resources :incidents do
      resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
    end
    resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
