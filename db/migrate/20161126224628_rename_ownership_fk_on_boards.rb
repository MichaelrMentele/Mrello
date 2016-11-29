class RenameOwnershipFkOnBoards < ActiveRecord::Migration[5.0]
  def change
    rename_column :boards, :owner_id, :ownership_id
  end
end
