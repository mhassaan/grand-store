class Admin::VariantsController < ApplicationController
	before_action :authenticate_admin

	def index
		@variants = Variant.all
	end

	def new
		@variant = Variant.new
	end

	def edit
		@variant = Variant.find params[:id]
	end

	def update
		@variant = get_variant.update_attributes variant_params
		if @variant
			flash[:notice] = "Variant updated successfully."
		else
			flash[:alert] = @variant.errors.full_messages.join('<br/>')
		end
		redirect_to action: 'index'
	end

	def create
		@variant = Variant.create variant_params
		if @variant.valid?
			flash[:notice] = "Variant created successfully."
		else
			flash[:alert] = @variant.errors.full_messages.join('<br/>')
		end
		redirect_to new_variant_path
	end

	def destroy
		get_variant.destroy
		flash[:notice] = "Variant removed successfully."
		redirect_to action: 'index'
	end

	private
	def variant_params
		params.require(:variant).permit(:display_name,:name,variant_values_attributes: [:id, :display_name, :name, :_destroy])
	end

	def get_variant
		Variant.find params[:id]
	end

end
