class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.string :name, null: false
      t.string :contact, null: false
      t.text :body, null: false
      t.boolean :checked, default: false, null: false
      
      t.timestamps
    end
  end
end
