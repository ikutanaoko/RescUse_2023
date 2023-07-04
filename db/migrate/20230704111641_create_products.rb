class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :giver_id, null: false, foreign_key: true
      t.string :name, null: false
      t.string :detail_page
      t.text :infomation, null: false
      t.integer :price, null: false
      t.integer :count, null: false
      t.boolean :is_closed, null: false, default: false
      t.boolean :is_used, null: false, default: false
      t.integer :taker_id, foreign_key: true

      t.timestamps
    end
  end
end
