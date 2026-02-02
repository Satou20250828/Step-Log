class CreateRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :records do |t|
      t.references :habit, null: false, foreign_key: true
      t.date :recorded_on, null: false
      t.string :status, null: false
      t.timestamps
    end
    add_index :records, [ :habit_id, :recorded_on ], unique: true
  end
end
