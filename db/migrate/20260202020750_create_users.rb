class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      # uuid カラムを追加し、空っぽ（null）を禁止にする
      t.string :uuid, null: false

      t.timestamps
    end
    # uuid で検索を速くし、かつ重複（同じID）を絶対に許さない設定
    add_index :users, :uuid, unique: true
  end
end
