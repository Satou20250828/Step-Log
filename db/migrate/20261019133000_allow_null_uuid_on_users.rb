class AllowNullUuidOnUsers < ActiveRecord::Migration[7.2]
  # 開発初期の users.uuid（NOT NULL）が本番DBにだけ残っており、新しいユーザーを作成できないため、
  # カラムがある場合だけ NOT NULL 制約を外す（データは削除しない）
  def up
    return unless column_exists?(:users, :uuid)

    change_column_null :users, :uuid, true
  end

  def down
    # 元に戻すと再び新しいユーザーを作成できなくなるため、何もしない
  end
end
