class DashboardController < ApplicationController
	before_action :authenticate_user!

	def index
		render role_template current_user
	end
end
