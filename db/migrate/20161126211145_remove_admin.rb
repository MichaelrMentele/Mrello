class RemoveAdmin < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :admin
    remove_column :users, :organization_id

    remove_column :organizations, :admin_id
  end
end
