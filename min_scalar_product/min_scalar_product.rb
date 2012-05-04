ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  x = ARGF.readline.split.map(&:to_i)
  y = ARGF.readline.split.map(&:to_i)
  x.sort!
  y.sort!.reverse!
  sum = 0
  x.size.times do |i|
    sum += x[i] * y[i]
  end
  puts "Case ##{count}: #{sum}"
end
