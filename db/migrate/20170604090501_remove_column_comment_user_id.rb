class RemoveColumnCommentUserId < ActiveRecord::Migration
  def change
    remove_column :comments, :user_id
  end
end
