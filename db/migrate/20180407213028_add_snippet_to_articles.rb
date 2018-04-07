class AddSnippetToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :snippet, :string
  end
end
