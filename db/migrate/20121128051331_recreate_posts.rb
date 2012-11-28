class RecreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :site_id
      t.integer :fields_id
      t.string :fields_type

      t.timestamps
    end
  end
end