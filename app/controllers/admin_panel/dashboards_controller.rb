# app/controllers/admin_panel/dashboards_controller.rb
module AdminPanel
  class DashboardsController < ApplicationController
    before_action :authenticate_admin!

    def show
    end
  end
end
