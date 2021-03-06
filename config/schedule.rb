# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# 出力先のログファイル
set :output, 'log/crontab.log'

# ジョブの実行環境定義
set :environment, :production

# Matching
# time_zonesテーブルのexecute_timeを元に各時間設定
every '50 10 * * *' do
  rake 'matching:execute[1]'
end

every '50 11 * * *' do
  rake 'matching:execute[2]'
end

every '50 12 * * *' do
  rake 'matching:execute[3]'
end

every '50 13 * * *' do
  rake 'matching:execute[4]'
end

# Data reset
every '59 23 * * *' do
  rake 'matching:reset'
end