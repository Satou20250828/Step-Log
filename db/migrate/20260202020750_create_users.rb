class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      # session_token カラムを追加し、空っぽ（null）を禁止にする
      t.string :session_token, null: false

      t.timestamps
    end
    # session_token で検索を速くし、かつ重複（同じID）を絶対に許さない設定
    add_index :users, :session_token, unique: true
  end
end
