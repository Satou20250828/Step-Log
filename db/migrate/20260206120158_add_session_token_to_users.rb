class AddSessionTokenToUsers < ActiveRecord::Migration[7.2]
  def up
    unless column_exists?(:users, :session_token)
      add_column :users, :session_token, :string
    end
    unless index_exists?(:users, :session_token, unique: true)
      add_index :users, :session_token, unique: true
    end

    # 既存ユーザーにトークンを付与
    if column_exists?(:users, :session_token)
      User.reset_column_information
      User.find_each do |user|
        user.update_columns(session_token: SecureRandom.base58(24)) if user.session_token.blank?
      end
    end

    if column_exists?(:users, :session_token)
      change_column_null :users, :session_token, false
    end
  end

  def down
    remove_index :users, :session_token
    remove_column :users, :session_token
  end
end
