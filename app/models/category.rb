class Category < ActiveRecord::Base

  # associations
  has_many :subcategories, dependent: :nullify
end
