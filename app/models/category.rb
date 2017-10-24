	class Category < ApplicationRecord
	has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category', required: false

	# has_many :category_variants,inverse_of: :category
	# accepts_nested_attributes_for :category_variants,reject_if: :all_blank, allow_destroy: true
	has_many :category_variants,inverse_of: :category
	accepts_nested_attributes_for :category_variants,allow_destroy: true, reject_if: proc { |attributes| attributes['variant_id'].blank? }


end
