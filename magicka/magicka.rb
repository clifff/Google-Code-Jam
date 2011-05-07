ARGF.readline
count = 0
ARGF.each do |input|
  count +=1 
  split_input = input.split(/(\d+ \D*)/).collect{|x| x.strip}.reject{|x| x.empty?}
  raise "Error parsing input" if split_input.size != 3


  #puts split_input.inspect

  combo_map = {}
  combos = split_input[0].sub(/\d+/, '').strip
  # splits the combos up into two chars and the result
  combos = combos.split(/(\w{3})/).collect{|x| x.strip}.reject{|x| x.empty?}
  combos.each do |combo|
    a = combo[0].chr
    b = combo[1].chr
    x = combo[2].chr
    combo_map[a+b] = x
    combo_map[b+a] = x
  end
  #puts "Combo_map: #{combo_map.inspect}"

  opposite_map = {}
  opposites = split_input[1].sub(/\d+/, '').strip
  opposites = opposites.split(/(\w{2})/).collect{|x| x.strip}.reject{|x| x.empty?}
  opposites.each do |opposite|
    a = opposite[0].chr
    b = opposite[1].chr
    opposite_map[a] = b
    opposite_map[b] = a
  end
  #puts "Opposite_map: #{opposite_map.inspect}"

  queue = split_input[2].sub(/\d+/, '').strip
  queue = queue.split(//)
  #puts "Queue #{queue.inspect}"

  elements = []
  while not queue.empty?
    el = queue.shift
    elements << el
    last_two = elements[-2..-1]
    last_two ||= []
    last_two = last_two.join
    if combo_map[last_two]
      #puts "found combo!"
      elements.pop(2)
      elements << combo_map[last_two]
    else
      #puts "no combo : ("
    end
    if opposite_map[elements.last] && elements.index(opposite_map[elements.last])
      #puts "CLEAR!"
      elements.clear
    end
  end

  #puts "Combos: #{combos.inspect}"
  #puts "Opposites: #{opposites.inspect}"
  result = elements.join(', ')

  puts "Case ##{count}: [#{result}]"
end
