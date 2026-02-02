class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :session_token, null: false
      t.timestamps
    end
    add_index :users, :session_token, unique: true
  end
end
