# app/controllers/staffs/registrations_controller.rb
class Staffs::RegistrationsController < Devise::RegistrationsController
  before_action :disable_signup!, only: %i[new create]

  private

  def disable_signup!
    render file: Rails.root.join('public/404.html'), layout: false, status: :not_found
  end
end
