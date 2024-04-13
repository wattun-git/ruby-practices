#!/usr/bin/env ruby
require 'optparse'
require 'date'

TargetMonthMargin = 15 # 表示対象の月・年表示の余白
DateMargin = 2 #カレンダーのDate間の余白

options = {}

# コマンドライン引数-m、-yで指定された値を月、年に代入する 
opt = ARGV.getopts('m:','y:')
options[:month] = opt['m'].to_i if opt['m']
options[:year] = opt['y'].to_i if opt['y']

# 引数が未指定だった場合、今月、今年を代入する
options[:month] ||= Date.today.month
options[:year] ||= Date.today.year

# 指定された月、年のカレンダーを表示する
puts "#{options[:month]}月 #{options[:year]}年".rjust(TargetMonthMargin)
puts '日 月 火 水 木 金 土'
# 指定された月の初日を取得する
first_day = Date.new(options[:year], options[:month], 1)

# 指定された月の最終日を取得する
last_day = Date.new(options[:year], options[:month], -1)

# 初日の曜日に応じて空白を表示する
print '   ' * first_day.wday

# カレンダーの日付を表示する
(first_day..last_day).each do |date|
  print date.day.to_s.rjust(DateMargin)
  print ' '
  # 日曜日の場合は改行する
  puts if date.saturday?
end

# calコマンドと同等の表示になるよう最後に改行を表示
puts
