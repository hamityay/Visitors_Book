class Subcategory < ActiveRecord::Base
  # Relations
  belongs_to :category
  has_many :places, dependent: :nullify

  validates_presence_of :name, :category_id
end
