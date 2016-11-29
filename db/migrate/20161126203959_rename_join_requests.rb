class RenameJoinRequests < ActiveRecord::Migration[5.0]
  def change
    rename_table :join_requests, :memberships
  end
end
