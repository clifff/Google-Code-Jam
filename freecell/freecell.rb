# d is how many games today
# g is how many games total
# g >= d
# p_sub_d is what percent of d games won today (won_today / d )
# p_sub_g is what percent of g games won total (won_total / sum_d)
# n is the MAX number of games today
# n >= d
# is it possible that p_sub_d == p_sub_g
#
# Divides evenly if d*100 / won_today has no remainder
# Divides evenly if sum_d*100 / won_total has no remainder
#
# Could have won between 0 and n games today
# if p_sub_d == 0, then won exactly 0
# else, min_won = 0, max_won = n * p_sub_d / 100
# p_sub_g =
#


ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  nums = input.split.collect{ |x| x.to_f }
  raise 'Error parsing input' if nums.length != 3
  n = nums[0].to_i
  p_sub_d = nums[1]
  p_sub_g = nums[2]
  result = "Broken"

  (n+1).times do |x|
    next if x == 0 && p_sub_d != 0

    won_today = (p_sub_d / 100.0) * x
    if (won_today % 1 == 0.0) && !(won_today != 0 && p_sub_g == 100)
      result = "Possible"
      break
    end
  end
  
  puts "Case ##{count}: #{result}"
end
