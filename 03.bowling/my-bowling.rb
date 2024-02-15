#!/usr/bin/env ruby

score = ARGV[0] # Stringを受け取る。もしintにしたければto_iを使う
scores = score.split(',')
shots = [] # shotsの配列を作る

scores.each do |score| # scoresの中身をsに入れる
  if score == 'X' # sがXなら
    shots << 10 # 10をshotsに入れる
    shots << 0  # 0をshotsに入れる
  else # それ以外なら
    shots << score.to_i # sをint(数字)にしてshotsに入れる
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

basic_point = 0
bonus_point = 0

# ベーシックポイントを計算
frames.each do |frame|
  basic_point += frame.sum
end

# ボーナスポイントを計算
frames[0..8].each_with_index do |frame, i|
  if frame[0] == 10 # そのフレームの1投目がストライク
    if frames[i+1] && frames[i+1][0] == 10 # 次のフレームの1投目もストライク
      bonus_point += 10 
      bonus_point += frames[i+2][0] if frames[i+2] # 次の次のフレームの1投目を追加
    elsif frames[i+1] # 次のフレームはあるが、1投目がストライクでない
      bonus_point += frames[i+1].sum # 次のフレームの合計(1投目、2投目)を追加
    end
  elsif frame.sum == 10 # スペア
    bonus_point += frames[i+1][0] if frames[i+1]
  end
end

total_point = basic_point + bonus_point

puts total_point
