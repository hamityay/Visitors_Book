class RemoveUserReferences < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.remove_references :user
    end
  end
end
