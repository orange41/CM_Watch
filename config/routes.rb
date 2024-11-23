Rails.application.routes.draw do
  root 'homes#top'
  get 'user_login', to: 'homes#user_login'
  get 'admin_login', to: 'homes#admin_login'
  get 'user_dashboard', to: 'homes#user_dashboard'
end

