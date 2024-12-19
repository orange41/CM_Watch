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

  resources :categories

  get 'staffs/dashboard', to: 'homes#user_dashboard', as: 'staffs_dashboard' # 修正
  namespace :staffs do
    resources :incidents
  end

  namespace :admin_panel do
    get 'dashboard', to: 'homes#admin_dashboard', as: 'admin_dashboard'
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
    resources :comments, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  resources :incidents, only: [] do
    resources :comments, only: [:create]
  end

  resources :staffs, only: [:index, :show] # 一般公開されるスタッフの詳細ページと一覧ページも追加
end
