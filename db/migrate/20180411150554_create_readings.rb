class CreateReadings < ActiveRecord::Migration[5.1]
  def change
    create_table :readings do |t|
      t.integer :user_id
      t.integer :article_id
      t.boolean :read?, default: false
      t.timestamps
    end
  end
end
