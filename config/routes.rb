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
  get 'about', to: 'homes#about', as: 'about'
  resources :categories

  get 'staffs/dashboard', to: 'homes#user_dashboard', as: 'staffs_dashboard'

  namespace :staffs do
    resources :incidents
  end

  resources :staffs, only: [:index, :show, :edit, :update, :destroy]

  get 'admin_panel/dashboard', to: 'homes#admin_dashboard', as: 'admin_panel_admin_dashboard'
  namespace :admin_panel do
    get 'dashboard/edit', to: 'dashboards#edit', as: 'edit_admin_dashboard'
    patch 'dashboard', to: 'dashboards#update', as: 'admin_dashboard_update'
    resources :staffs, only: [:index, :show, :new, :create, :destroy]
    resources :incidents do
      member do
        patch :approve
        patch :reject
      end
      resources :comments do
        member do
          patch :approve
          patch :reject
        end
      end
    end
    resources :comments, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      member do
        patch :approve
        patch :reject
      end
      collection do
        get :all_comments
      end
    end
  end

  resources :incidents, only: [] do
    resources :comments, only: [:create]
  end
end
