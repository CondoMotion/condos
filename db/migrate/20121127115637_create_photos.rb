class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.references :site
      t.references :user
      t.integer :permission
      t.string :attachment

      t.timestamps
    end
    add_index :photos, :site_id
    add_index :photos, :user_id
  end
end
