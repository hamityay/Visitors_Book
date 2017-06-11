class Category < ActiveRecord::Base

  # associations
  has_many :subcategories, dependent: :nullify
  has_many :places, through: :subcategories
end
