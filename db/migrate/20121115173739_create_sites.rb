class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :subdomain
      t.references :company
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.text :description

      t.timestamps
    end
    add_index :sites, :company_id
  end
end
