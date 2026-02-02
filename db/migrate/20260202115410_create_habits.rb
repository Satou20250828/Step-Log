class CreateHabits < ActiveRecord::Migration[7.1]
  def change
    create_table :habits do |t|
      # index: { unique: true } を追加して「1人1つ」をDBレベルで強制
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :name, null: false

      t.timestamps
    end
  end
end
