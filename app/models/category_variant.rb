class CategoryVariant < ApplicationRecord
	belongs_to :category,optional: true
end
