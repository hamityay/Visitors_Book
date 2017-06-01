class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.text :address
      t.text :description
      t.string :phone
      t.string :email
      t.boolean :is_active
      t.string :latitude
      t.string :longitude
      t.references :subcategory, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
