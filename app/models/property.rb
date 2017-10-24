class Property < ApplicationRecord
	validates :name, :display_name, presence: true
end
