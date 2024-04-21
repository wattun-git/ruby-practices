#!/usr/bin/env ruby
# frozen_string_literal: true

MAX_KNOCKED_DOWN_PIN = 10 # 1フレームで倒せるピンの最大数
LAST_FRAME_NUMBER = 10 # 最終フレームの番号

def strike?(frame)
  frame[0] == MAX_KNOCKED_DOWN_PIN
end

def spare?(frame)
  frame[0] + frame[1] == MAX_KNOCKED_DOWN_PIN && !strike?(frame)
end

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  shots << if s == 'X'
             MAX_KNOCKED_DOWN_PIN
           else
             s.to_i
           end
end

frames =
  Array.new(10) do |i|
    if i == LAST_FRAME_NUMBER - 1
      shots.slice!(0..-1)
    elsif strike?(shots[0..1])
      ary = []
      ary << shots.slice!(0) # 配列として返すようにaryに追加
    else
      shots.slice!(0..1)
    end
  end

point = 0
frames.each_with_index do |frame, index|
  next_frame = frames[index + 1]
  current_frame_number = index + 1

  if current_frame_number != LAST_FRAME_NUMBER
    if strike?(frame)
      frame << next_frame[0]
      frame << if next_frame.size > 1
                 next_frame[1]
               else
                 frames[index + 2][0]
               end
    elsif spare?(frame)
      frame << next_frame[0]
    end
  end
  point += frame.sum
end

puts point
