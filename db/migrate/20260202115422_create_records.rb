class CreateRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :recorded_on, null: false
      t.integer :result, null: false, default: 0

      t.timestamps
    end
    # 同じユーザーが同じ日に2回記録できないようにする（1日1回制約）
    add_index :records, [:user_id, :recorded_on], unique: true
  end
end