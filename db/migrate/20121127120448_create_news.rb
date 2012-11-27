class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :content
      t.references :site
      t.references :user
      t.integer :permission

      t.timestamps
    end
    add_index :news, :site_id
    add_index :news, :user_id
  end
end
