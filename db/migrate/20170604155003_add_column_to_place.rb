class AddColumnToPlace < ActiveRecord::Migration
  def change
    add_column :places, :commentable_count, :integer
  end
end
