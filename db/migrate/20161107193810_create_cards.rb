class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.integer :list_id
      t.string :title
      t.timestamps
    end
  end
end
