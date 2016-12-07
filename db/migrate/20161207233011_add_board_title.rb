class AddBoardTitle < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :title, :string, default: "Untitled"
  end
end
