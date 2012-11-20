class AddTemporaryPasswordToSites < ActiveRecord::Migration
  def change
    add_column :sites, :temp_pw, :string
  end
end
