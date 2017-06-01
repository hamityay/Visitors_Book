class Subcategory < ActiveRecord::Base
  # Relations
  belongs_to :category
  has_many :places
end
