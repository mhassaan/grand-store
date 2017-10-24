class Admin::CategoriesController < ApplicationController
	before_action :authenticate_admin

	def index
		@categories = Category.all
	end

	def new
		@category = Category.new
		@category.category_variants.build
	end

	def edit
		@category = get_category
	end

	def update
		@category = get_category.update_attributes category_params
		if @category
			flash[:notice] = "Category updated successfully."
		else
			flash[:alert] = @category.errors.full_messages.join('<br/>')
		end
		redirect_to categories_path
		#render json:{id:1}
	end

	def create
		#category = Category.create category_params
		category = Category.new category_params
		if category.save
			arr_ids = params[:category][:category_variants_attributes]["0"]["variant_id"].uniq.reject(&:empty?)
			arr_ids.each do |d|
				CategoryVariant.create(variant_id: d,category_id: category.id)
			end
		end
		puts category.errors.full_messages
		redirect_to categories_path
	end

	def destroy
		get_category.destroy
		flash[:notice] = "Variant removed successfully."
		redirect_to categories_path
		#redirect_to action: 'index'
	end

	def get_root_node
		# this function gets root node and build its tree accordingly.
		category = JstreeService.get_root_node params
		render json: category
	end

	def add_node_to_tree
		category = JstreeService.add_node_to_tree params
		render json: {id: category.id,title: category.title,node_search_id: category.node_search_id}
	end

	def update_node_text
		category = JstreeService.update_node_text params
		render json: {title: category.title}
	end


	private

	def category_params
		params.require(:category).permit(:title, category_variants_attributes: [:variant_id,:category_id,:id,'_destroy'])
	end

	def get_category
		data = Category.find params[:id]
	end

	# def category_params
	# 	params.require(:category).permit(:title, category_variants_attributes: {})
	# end

	# def category_params
	# 	params.require(:category).permit(:title,:category_variants_attributes).tap do |whitelisted|
	#   	whitelisted[:category_variants_attributes ] = params[:category][:category_variants_attributes ]
	# 	end
	# end
#{}"category_variants_attributes"=>{"0"=>{"variant_id"=>["", "14"]}}

end
