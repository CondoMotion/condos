class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.references :site
      t.references :user
      t.integer :permission
      t.string :attachment

      t.timestamps
    end
    add_index :documents, :site_id
    add_index :documents, :user_id
  end
end
