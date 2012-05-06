RESULTS = {}
def contains_sum?(sum, arr)
  RESULTS[sum] ||= {}
  if !RESULTS[sum][arr].nil?
    return RESULTS[sum][arr]
  end
  puts "probing #{arr.inspect} for #{sum}"

  if sum == 1 || arr.empty? || sum < arr.min
    RESULTS[sum][arr] = false
    return RESULTS[sum][arr]
  end
  total = arr.inject(:+)
  if sum == total
    RESULTS[sum][arr] = true
    return RESULTS[sum][arr]
  elsif arr.include?(sum)
    RESULTS[sum][arr] = true
    return RESULTS[sum][arr]
  elsif total > sum
    arr = arr.reject{|x| x > sum || (x + arr.min) > sum}
    return arr.any?{|x| contains_sum?(sum, arr.reject{|y| y == x}) }
  else
    RESULTS[sum][arr] = false
    return RESULTS[sum][arr]
  end
end

ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  nums = input.split.drop(1).map(&:to_i).sort
  (1...nums.size).each do |i|
    sum = nums.first(i).inject(:+)
    puts "proping sum: #{sum}"
    result = contains_sum?(sum, nums.drop(i))
    if result
      puts "OMG found sum #{sum}"
      break
    end
  end
  puts "Case ##{count}:"
  puts input
end
