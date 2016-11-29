class MoveOwnershipToBoard < ActiveRecord::Migration[5.0]
  def change
    rename_column :boards, :ownership_id, :owner_id
    add_column :boards, :owner_type, :string

    drop_table :ownerships
  end
end
