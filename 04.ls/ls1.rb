#!/usr/bin/env ruby
# frozen_string_literal: true

DISPLAY_COLUMN_NUMBER = 3
TERMINAL_WIDTH = `tput cols`.to_i

def get_files(path)
  Dir.open(path).each_child.reject { |file| file.start_with?('.') }.sort
end

def transpose_files(files)
  display_row = (files.size.to_f / DISPLAY_COLUMN_NUMBER).ceil
  return [files] if display_row <= 1

  files_sliced_by_columns = files.each_slice(display_row)
  max_size = files_sliced_by_columns.map(&:size).max
  files_sliced_by_columns
    .map { |file| file.fill(nil, file.size...max_size) }
    .transpose
    .each { |file| file.reject!(&:nil?) }
end

def display_files(files_sliced_by_rows)
  files_sliced_by_rows.each do |files_per_row|
    files_per_row.each do |file|
      print file.ljust(TERMINAL_WIDTH / DISPLAY_COLUMN_NUMBER)
    end
    print "\n"
  end
end

path = ARGV[0] || '.'
files = get_files(path)
files_sliced_by_rows = transpose_files(files)
display_files(files_sliced_by_rows)
