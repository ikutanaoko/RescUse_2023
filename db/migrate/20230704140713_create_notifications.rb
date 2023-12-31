class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :product_id
      t.integer :parent_id
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
