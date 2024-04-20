#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'date'

TARGET_MONTH_BLANK_SPACE = 15
DATE_BLANK_SPACE = 2

options = {}

opt = ARGV.getopts('m:', 'y:')
options[:month] = opt['m'].to_i if opt['m']
options[:year] = opt['y'].to_i if opt['y']
options[:month] = opt['m']&.to_i || Date.today.month
options[:year] = opt['y']&.to_i || Date.today.year

puts "#{options[:month]}月 #{options[:year]}年".rjust(TARGET_MONTH_BLANK_SPACE)
puts '日 月 火 水 木 金 土'
first_date = Date.new(options[:year], options[:month], 1)
last_date = Date.new(options[:year], options[:month], -1)
print '   ' * first_date.wday
(first_date..last_date).each do |date|
  print date.day.to_s.rjust(DATE_BLANK_SPACE)
  print ' '
  puts if date.saturday? && date != last_date
end
puts "\n\n"
