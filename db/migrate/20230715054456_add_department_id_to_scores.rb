class AddDepartmentIdToScores < ActiveRecord::Migration[6.1]
  def change
    add_column :scores, :department_id, :integer, null: false
  end
end
