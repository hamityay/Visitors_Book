class Subcategory < ActiveRecord::Base
  # Relations
  belongs_to :category
  has_many :places

  validates_presence_of :name, :category_id
end
