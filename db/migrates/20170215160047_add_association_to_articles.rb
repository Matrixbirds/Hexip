class AddAssociationToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :author_id, :integer
    add_index :articles, :author_id
  end
end
