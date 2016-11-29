class AlterBoardUserIdFkName < ActiveRecord::Migration[5.0]
  def change
    rename_column :boards, :admin_id, :owner_id
  end
end
