class RemoveContentFromNews < ActiveRecord::Migration
  def up
    remove_column :news, :content
    add_column :news, :content, :text
  end

  def down
    add_column :news, :content, :string
  end
end
