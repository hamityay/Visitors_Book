class City < ActiveRecord::Base

  # Helpers
  audited

  # Relations
  belongs_to :country
  has_many :places

  # Validations
  validates_presence_of :name, :country_id

end
