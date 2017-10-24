class OptionValue < ApplicationRecord
	belongs_to :option_value, class_name: 'Option',foreign_key: 'option_id'
end
