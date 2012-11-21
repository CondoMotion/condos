class RemoveTempPwFromSites < ActiveRecord::Migration
  def change
  	remove_column :sites, :temp_pw, :string
  end
end
