class JstreeService
	attr_reader :node_text, :parent_id

	def initialize args
		@node_text = args[:node_text]
		@parent_id =  arg[:parent_id]
	end


	def self.build_tree category,product
		if category.subcategories.present?
			subcategories = category.subcategories
			subcategories.each do |sub|
				parent_id = (sub.parent.present?)? sub.parent.id : '#'
				product << {'id': sub.id,'parent': parent_id ,'text': sub.title}
				cat = Category.find sub.id
				if sub.subcategories.present?
					build_tree cat, product
				end
			end
		else
			product
		end
	end

	def self.get_root_node args
		product = []
		category = Category.find args[:category_id]
		parent_id = '#'
		product << {'id': category.id,'parent': parent_id ,'text': category.title}
		build_tree category,product
		product
		#render json: product
	end

	def self.add_node_to_tree args
		node_search_id = Digest::MD5.hexdigest(Time.now.to_s)
		category = Category.create(title: args[:node_text],parent_id: args[:parent_id],node_search_id: node_search_id)
		category
	end

	def self.update_node_text args
		category = Category.find args[:id]
		category.update_attributes(title: args[:text])
	end

end
