class Admin::OptionsController < ApplicationController
	before_action :authenticate_admin

		def index
			@options = Option.all
		end

		def new
			@option = Option.new
		end

		def edit
			@option = Option.find params[:id]
		end

		def update
			@option = get_option.update_attributes option_params
			if @option
				flash[:notice] = "Option updated successfully."
			else
				flash[:alert] = @option.errors.full_messages.join('<br/>')
			end
			redirect_to action: 'index'
		end

		def create
			@option = Option.create option_params
			if @option.valid?
				flash[:notice] = "Option created successfully."
			else
				flash[:alert] = @option.errors.full_messages.join('<br/>')
			end
			redirect_to new_option_path
		end

		def destroy
			get_option.destroy
			flash[:notice] = "Variant removed successfully."
			redirect_to action: 'index'
		end

		private
		def option_params
			params.require(:option).permit(:display_name,:name,option_values_attributes: [:id, :display_name, :name, :_destroy])
		end

		def get_option
			Option.find params[:id]
		end

end
