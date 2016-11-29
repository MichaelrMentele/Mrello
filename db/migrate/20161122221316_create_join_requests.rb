class CreateJoinRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :join_requests do |t|
      t.integer :organization_id, :user_id
      t.timestamps
    end
  end
end
