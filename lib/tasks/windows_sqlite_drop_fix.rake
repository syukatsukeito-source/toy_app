# frozen_string_literal: true

# Workaround for SQLite file lock errors on Windows during `rails db:drop`.
if Gem.win_platform?
  namespace :db do
    task disconnect_sqlite_on_windows: :environment do
      ActiveRecord::Base.connection_handler.connection_pool_list.each do |pool|
        next unless pool.db_config&.adapter == "sqlite3"

        begin
          pool.release_connection
        rescue StandardError
          nil
        end

        begin
          pool.disconnect!
        rescue StandardError
          nil
        end
      end

      begin
        ActiveRecord::Base.clear_all_connections!
      rescue StandardError
        nil
      end

      GC.start
      sleep 0.1
    end
  end

  Rake::Task["db:drop:_unsafe"].enhance(["db:disconnect_sqlite_on_windows"])
end
