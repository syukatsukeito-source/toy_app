# Pumaの設定ファイル
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
workers_count = ENV.fetch("WEB_CONCURRENCY") { 0 }.to_i
workers workers_count if workers_count.positive?
preload_app! if workers_count.positive?
plugin :tmp_restart unless Gem.win_platform?

