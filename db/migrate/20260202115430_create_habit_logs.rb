class CreateHabitLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :habit_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :event

      t.timestamps
    end
  end
end
