class Place < ActiveRecord::Base

  ratyrate_rateable "advice", "fun", "service", "taste"

  # relations
  belongs_to :subcategory
  belongs_to :country
  belongs_to :city
  has_and_belongs_to_many :users
  has_many :images, dependent: :destroy
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :subcategory
  accepts_nested_attributes_for :city
  accepts_nested_attributes_for :country
end
