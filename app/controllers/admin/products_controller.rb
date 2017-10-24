class Admin::ProductsController < ApplicationController
	before_action :authenticate_admin

	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.create(name: product_params[:name], master_price: product_params[:master_price], cost_price: product_params[:cost_price])
		if @product.valid?
			#@product.variants = eval(product_params[:variant_ids])
			product_variant_options = JSON.parse(product_params[:option_ids])
			# Creating variants for a product.
			product_variant_options.each do |p_options|
				@product.varaints.create(p_option[:option_id])
			end
			
			# variant_combinations = []
			#
			# product_variants.each do |v|
			# 	variant_combinations << (v.values)
			# end
			#
			# # Stashing multiple variant values under variant key
			# h = Hash.new{|hsh,key| hsh[key] = [] }
			# product_variants.each do |v|
			# 	h[v["variant_id"]] << v["variant_value_id"]
			# end
			#
			# variant_value_ids = h.values
			# combination_array = []
			#
			# variant_value_ids.each_with_index do |value, index|
			# 	value.each_with_index do |value2,index2|
			# 		temp = []
			# 		temp.push value2
			# 		if variant_value_ids[index+1].present?
			# 			combination_array << calculate_variant(temp,variant_value_ids[index+1])
			# 		else
			# 			combination_array << temp
			# 		end
			# 	end
			# end
			# product_variants.each do |v|
			# 	@product.product_variants.create(variant_id: v["variant_id"], variant_value_id: v["variant_value_id"])
			# end
			flash[:notice] = "Product created successfully."
		else
			flash[:error] = @product.errors.full_messages.join('<br/>')
		end
		redirect_to products_path
	end

	def calculate_variant arg1,arg2
		result = arg1.product(arg2)
	end

	# def get_product_variant_tree
	# 	variant_values = []
	# 	variant = Variant.find params[:id]
	# 	parent_id = '#'
	# 	variant_values << {'id': variant.id,'parent': parent_id ,'text': variant.display_name}
	# 	variant.variant_values.each do |f| variant_values <<{'id': f.id, 'parent': variant.id, 'text': f.display_name}  end if variant.variant_values.present?
	# 	render json: variant_values
	# end

	def get_product_options_tree
		result = []
		option = Option.find params[:id]
		parent_id = '#'
		result << {'id': option.id,'parent': parent_id ,'text': option.display_name}
		option.option_values.each do |f| result <<{'id': f.id, 'parent': option.id, 'text': f.display_name}  end if option.option_values.present?
		render json: result
	end

	# def get_variant_values
	# 	result = []
	# 	variant = Variant.find params[:product_id]
	# 	variant_values = variant.variant_values
	# 	variant_values.each do |f| result <<{'id': f.id, 'parent': variant.id, 'text': f.display_name}  end if variant_values.present?
	# 	render json: result
	# end

	def get_option_values
		result = []
		option = Option.find params[:product_id]
		option_values = option.option_values
		option_values.each do |f| result <<{'id': f.id, 'parent': option.id, 'text': f.display_name}  end if option_values.present?
		render json: result
	end

	private

	def product_params
		params.require(:product).permit(:name, :master_price, :cost_price,:option_ids)
	end
end
