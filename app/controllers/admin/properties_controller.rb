class Admin::PropertiesController < ApplicationController
	before_action :authenticate_admin

	def index
		@properties = Property.all
	end

	def new
		@property = Property.new
	end

	def edit
		@property = Property.find params[:id]
	end

	def update
		@property = get_property.update_attributes property_params
		if @property.save!
			flash[:notice] = "Record updated successfully."
		else
			flash[:alert] = @property.errors.full_messages.join('<br/>')
		end
		redirect_to action: 'index'
	end

	def create
		@property = Property.create properties_params
		if @property.valid?
			flash[:notice] = "Property added successfully."
		else
			flash[:alert] = @property.errors.full_messages.join('<br/>')
		end
		redirect_to new_property_path
	end

	def destroy
		get_property.destroy
		flash[:notice] = "Property removed successfully."
		redirect_to action: 'index'
	end

	private
	def properties_params
		params.require(:property).permit(:name, :display_name)
	end

	def get_property
		Property.find params[:id]
	end
end
