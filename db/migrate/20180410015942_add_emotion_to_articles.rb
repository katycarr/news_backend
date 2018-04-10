class AddEmotionToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :emotion, :string
  end
end
