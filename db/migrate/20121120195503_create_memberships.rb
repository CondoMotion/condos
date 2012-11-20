class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :site
      t.references :user
      t.string :role

      t.timestamps
    end
    add_index :memberships, :site_id
    add_index :memberships, :user_id
  end
end
