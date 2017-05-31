class Category < ActiveRecord::Base

  # associations
  has_many :subcategories
end
