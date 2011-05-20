# hackery!
class Array; def bad_sum; inject( nil ) { |sum,x| sum ? sum ^ x : x }; end; end
class Array; def sum; inject( nil ) { |sum,x| sum ? sum+x : x }; end; end

def perms(n, list, biggest)
  result = []
  if biggest && biggest >= list[-n..-1].sum
    return []
  end
  combinations = list.combination(n)
  combinations.each do |x|
    result << [x, list-x] if x.bad_sum == (list-x).bad_sum
  end
  result
end

ARGF.readline
count = 0
ARGF.each_slice(2) do |input|
  count +=1 

  candies = input[1].split(' ').collect{ |x| x.to_i }.sort
 #puts candies.inspect

  big_pile = nil
  if candies.bad_sum == 0
    (1..candies.size-1).each do |chunk_size|
    combos = perms(chunk_size, candies, big_pile)
    #puts "Chunk size: #{chunk_size}"
    #puts "Combos: #{combos.inspect}"
    combos.each do |combo|
      #puts "Combo 1: #{combo[0].inspect}"
      #puts "Combo 2: #{combo[1].inspect}"
      if combo[0].bad_sum == combo[1].bad_sum
        #puts "Equality found!"
        pile_one = combo[0].sum
        pile_two = combo[1].sum
        biggest = pile_one > pile_two ? pile_one : pile_two
        big_pile = biggest if big_pile.nil?
        big_pile = biggest if biggest > big_pile
      end
    end
    end
  end


  #split_input = input.split(/(\d+ \D*)/).collect{|x| x.strip}.reject{|x| x.empty?}
  #raise "Error parsing input" if split_input.size != 3

  big_pile = "NO" if big_pile.nil?
  puts "Case ##{count}: #{big_pile}"
end
