class RoleService

	def initialize args
		@new_user = args
	end

	def add_role
	end

	def add_default_role
		@new_user.add_role(:newuser) if @new_user.roles.blank?
	end

	def remove_role
	end

	def update_role
	end

end
