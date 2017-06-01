class Place < ActiveRecord::Base
  # relations
  belongs_to :subcategory
  belongs_to :country
  belongs_to :city
  has_and_belongs_to_many :users
end
