class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :commentable_count, :integer
  end
end
