class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :company
      t.string :name
      t.integer :permission

      t.timestamps
    end
    add_index :roles, :company_id
  end
end
