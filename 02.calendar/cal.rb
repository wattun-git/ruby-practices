#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'date'

DATE_WIDTH = 2

opt = ARGV.getopts('m:', 'y:')
month = opt['m']&.to_i || Date.today.month
year = opt['y']&.to_i || Date.today.year

puts "      #{month}月 #{year}年"
puts '日 月 火 水 木 金 土'
first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
print '   ' * first_date.wday
(first_date..last_date).each do |date|
  print date.day.to_s.rjust(DATE_WIDTH)
  print ' '
  puts if date.saturday? && date != last_date
end
puts "\n\n"
