ARGF.readline
count = 0
ARGF.each_slice(3) do |input|
  count += 1
  credit = input[0].to_i
  orig = input[2].split.collect{|x| x.to_i}
  found = false
  orig.each_with_index do |value, i|
    break if found
    candidates = orig.select{ |x| x == credit - value }
    next if candidates.nil?
    candidates.each do |x|
      if (x == value)
        next if orig.rindex(x) == orig.index(x)
        second_index = orig[i+1..-1].index(x) + i + 1
        puts "Case ##{count}: #{i+1} #{second_index+1}"
        found = true
      else
        second_index = orig.index(x)
        puts "Case ##{count}: #{i+1} #{second_index+1}"
        found = true
      end
      break if found
    end
  end
end
