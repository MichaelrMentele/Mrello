class AllowNullUsersOrgId < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :organization_id, :integer, null: true
  end
end
