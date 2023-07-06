class RenameInfomationColumnToProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :infomation, :information
  end
end
