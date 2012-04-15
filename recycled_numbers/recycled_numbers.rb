def how_many_digits num
  how_many = 0
  while num > 0
    how_many += 1
    num /= 10
  end
  how_many
end

def recycled_numbers(num)
  temp = num
  components = []
  recycled_numbers = []
  while(temp > 0)
    components.unshift( temp % 10 )
    temp = temp / 10
  end

  (1...components.length).each do |i|
    temp_arr = components.clone
    i.times do
      temp_arr << temp_arr.shift
    end
    recycled_val = 0
    temp_arr.each_with_index do |x,i|
      recycled_val += 10**(temp_arr.length - i - 1) * x
    end
    # Dont add the value if there are leading zeroes
    if how_many_digits(recycled_val) == components.size && recycled_val != num
      recycled_numbers << recycled_val
    end
  end
  recycled_numbers.sort
end

if __FILE__ == $0
  ARGF.readline
  count = 0
  ARGF.each do |input|
    count += 1
    input = input.split.collect{|x| x.to_i}
    pairs = []
    range = (input[0]..input[1])
    range.each do |x|
      recycled_numbers(x).each do |y|
        if range.include?(y)
          potential_pair = [x,y].sort
          pairs << potential_pair unless pairs.include?(potential_pair)
        end
      end
    end
    puts "Case ##{count}: #{pairs.size}"
  end
end
