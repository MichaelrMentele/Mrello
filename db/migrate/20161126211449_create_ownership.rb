class CreateOwnership < ActiveRecord::Migration[5.0]
  def change
    create_table :ownerships do |t|
      t.string :owner_type
      t.integer :owner_id
      t.timestamps
    end
  end
end
