class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	def after_sign_up_path_for resource
		dashboard_path
	end

	def after_sign_in_path_for resource
		dashboard_path
	end

	def after_sign_out_path_for resource_or_scope
		if resource_or_scope == :user
			root_path
		end
	end

	def authenticate_admin
		if current_user.present?
			true if current_user.roles.where(name:'admin').present?
		else
			flash[:error] = "You are not allowed to access thie admin portal."
			redirect_to root_path
		end
	end

	private
	def role_template resource
		if resource.roles.where(name:'admin').first
			"/dashboard/admin_dashboard.html.erb"
		else
			"/dashboard/user_dashboard.html.erb"
		end
	end
end
