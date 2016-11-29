class AlterListsFkToBoards < ActiveRecord::Migration[5.0]
  def change
    rename_column :lists, :user_id, :board_id
  end
end
