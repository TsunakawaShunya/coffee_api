#!/usr/bin/env bash
set -o errexit

# 1. 依存関係インストール
bundle install --jobs=4 --retry=3

# 2. データベース状態リセット（慎重に実行）
echo "== Resetting database state =="
bundle exec rails db:drop db:create db:schema:load DISABLE_DATABASE_ENVIRONMENT_CHECK=1

# 3. マイグレーション再実行（詳細ログ付き）
echo "== Re-running migrations =="
bundle exec rails db:migrate VERBOSE=1 --trace

# 4. シードデータ再投入（オプション）
echo "== Re-seeding data =="
bundle exec rails db:seed SKIP_VALIDATION=1