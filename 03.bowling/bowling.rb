#!/usr/bin/env ruby
# frozen_string_literal: true

MAX_KNOCKED_DOWN_PIN = 10 # 1フレームで倒せるピンの最大数
LAST_FRAME_NUMBER = 10 # 最終フレームの番号

def strike?(frame)
  frame[0] == MAX_KNOCKED_DOWN_PIN
end

def spare?(frame)
  frame[0] + frame[1] == MAX_KNOCKED_DOWN_PIN
end

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X'
    shots << MAX_KNOCKED_DOWN_PIN
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  frames << shot
end

frames.each do |frame|
  frame.pop if strike?(frame)
end

if frames.size > LAST_FRAME_NUMBER
  frames[LAST_FRAME_NUMBER - 1] += frames[LAST_FRAME_NUMBER..].flatten
  frames.slice!(LAST_FRAME_NUMBER..-1)
end

point = 0
frames.each_with_index do |frame, index|
  next_frame = frames[index + 1]
  two_frames_ahead = frames[index + 2]
  current_frame_number = index + 1

  if current_frame_number != LAST_FRAME_NUMBER
    if strike?(frame)
      frame << next_frame[0]
      frame << if next_frame.size > 1
                 next_frame[1]
               else
                 two_frames_ahead[0]
               end
    elsif spare?(frame)
      frame << next_frame[0]
    end
  end
  point += frame.sum
end

puts point
