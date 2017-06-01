class Place < ActiveRecord::Base
  belongs_to :subcategory
  belongs_to :country
  belongs_to :city
end
