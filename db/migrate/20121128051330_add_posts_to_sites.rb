class AddPostsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :post_id, :integer
    add_column :sites, :post_type, :string
    drop_table :posts
  end
end
