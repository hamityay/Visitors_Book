class ChangeColumnDefaultPlaces < ActiveRecord::Migration
  def change
    change_column_default :places, :is_active, false
  end
end
