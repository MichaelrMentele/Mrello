class AddApprovalToJoinRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :join_requests, :approved, :boolean, default: false
  end
end
