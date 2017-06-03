class AddPlaceToImage < ActiveRecord::Migration
  def change
    add_reference :images, :place, index: true, foreign_key: true
  end
end
