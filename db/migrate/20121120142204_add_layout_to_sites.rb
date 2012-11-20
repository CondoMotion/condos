class AddLayoutToSites < ActiveRecord::Migration
  def change
    add_column :sites, :layout_name, :string
    add_column :sites, :custom_layout_content, :text
  end
end
