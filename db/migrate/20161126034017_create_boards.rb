class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.integer :admin_id
      t.timestamps
    end
  end
end
