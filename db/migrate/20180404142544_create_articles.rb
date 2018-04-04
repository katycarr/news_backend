class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :source
      t.string :url
      t.datetime :published_at
      t.string :img_url

      t.timestamps
    end
  end
end
