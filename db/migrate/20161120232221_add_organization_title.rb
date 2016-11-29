class AddOrganizationTitle < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :title, :string
  end
end
