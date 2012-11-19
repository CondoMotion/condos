class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :site
      t.references :permission

      t.timestamps
    end
    add_index :posts, :site_id
    add_index :posts, :permission_id
  end
end
