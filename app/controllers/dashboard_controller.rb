class DashboardController < ApplicationController
	def ng
		@base_url = "/dashboard/ng"
		render :index
	end

	def index
		respond_to do |format|
			format.html {
			redirect_to dashboard_ng_path
			}
		end
	end
end
