#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing gems"
bundle install --path vendor/bundle

echo "==> Precompiling assets"
bundle exec rails assets:precompile

echo "==> Ensuring session_token column migration safety"

# マイグレーションID（ファイル名の先頭14桁）
MIGRATION_VERSION="20260206120158"

# もし users.session_token が既に存在するなら、schema_migrations に stamp して失敗を回避
bundle exec rails runner <<'RUBY'
conn = ActiveRecord::Base.connection
if conn.column_exists?(:users, :session_token)
  version = "20260206120158"
  conn.execute("INSERT INTO schema_migrations (version) VALUES ('#{version}') ON CONFLICT DO NOTHING")
  puts "session_token already exists; stamped migration #{version}"
else
  puts "session_token not found; will migrate normally"
end
RUBY

echo "==> Running db:migrate"
bundle exec rails db:migrate

echo "==> Build done"
