class Place < ActiveRecord::Base
  # relations
  belongs_to :subcategory
  belongs_to :country
  belongs_to :city
  has_and_belongs_to_many :users
  has_many :images

  accepts_nested_attributes_for :subcategory
  accepts_nested_attributes_for :city
  accepts_nested_attributes_for :country
end
