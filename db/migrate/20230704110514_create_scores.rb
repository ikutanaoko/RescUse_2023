class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :active_score
      t.integer :passive_score

      t.timestamps
    end
  end
end
