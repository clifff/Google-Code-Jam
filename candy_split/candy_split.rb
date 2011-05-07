def bad_add(a, b)
  a = a.to_s(2).split(//).collect{|x| x.to_i}
  b = b.to_s(2).split(//).collect{|x| x.to_i}

  if a.size >= b.size
    length = a.size
    (a.size - b.size).times do
      b.unshift(0)
    end
  else
    length = b.size
    (b.size - a.size).times do
      a.unshift(0)
    end
  end
  result = Array.new(length, 0)
  raise 'Error resizing binary arrays' if a.size != b.size

  length.times do |x|
    pos = -x - 1
    result[pos] = a[pos] + b[pos]
    result[pos] = 0 if result[pos] == 2
  end
  result = eval "0b#{result.join}"
end

def perms(n, list)
  result = []
  combinations = list.combination(n)
  combinations.each do |x|
    result << [x, list-x]
  end
  result
end

# hackery!
class Array; def bad_sum; inject( nil ) { |sum,x| sum ? bad_add(sum, x) : x }; end; end
class Array; def sum; inject( nil ) { |sum,x| sum ? sum+x : x }; end; end

ARGF.readline
count = 0
ARGF.each_slice(2) do |input|
  count +=1 

  candies = input[1].split(' ').collect{ |x| x.to_i }
 #puts candies.inspect

  big_pile = nil
  (1..candies.size-1).each do |chunk_size|
    combos = perms(chunk_size, candies)
    #puts "Chunk size: #{chunk_size}"
    #puts "Combos: #{combos.inspect}"
    combos.each do |combo|
      #puts "Combo 1: #{combo[0].inspect}"
      #puts "Combo 2: #{combo[1].inspect}"
      if combo[0].bad_sum == combo[1].bad_sum
        #puts "Equality found!"
        pile_one = combo[0].sum
        pile_two = combo[1].sum
        big_pile = pile_one > pile_two ? pile_one : pile_two
      end
    end
  end


  #split_input = input.split(/(\d+ \D*)/).collect{|x| x.strip}.reject{|x| x.empty?}
  #raise "Error parsing input" if split_input.size != 3

  big_pile = "NO" if big_pile.nil?
  puts "Case ##{count}: #{big_pile}"
end
