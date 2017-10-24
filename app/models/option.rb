class Option < ApplicationRecord
	validates :name, :display_name, presence: true
	has_many :option_values, inverse_of: 'option_value'
	accepts_nested_attributes_for :option_values, reject_if: :all_blank, allow_destroy: true
end
