class Interest < ActiveRecord::Base
  # associations
  has_and_belongs_to_many :users
end
