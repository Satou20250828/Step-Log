class AddSessionTokenToUsers < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :session_token, :string
    add_index :users, :session_token, unique: true

    # 既存ユーザーにトークンを付与
    User.reset_column_information
    User.find_each do |user|
      user.update_columns(session_token: SecureRandom.base58(24)) if user.session_token.blank?
    end

    change_column_null :users, :session_token, false
  end

  def down
    remove_index :users, :session_token
    remove_column :users, :session_token
  end
end
