def diamond_inheritance?(class_num, inheritance)
  checked = []
  parents = inheritance[class_num - 1].clone
  while !parents.empty?
    checking = parents.pop
    if checked.index(checking)
      return true
    else
      checked << checking
      parents += inheritance[checking - 1]
    end
  end
  return false
end

if __FILE__ == $0
  ARGF.readline
  count = 0
  ARGF.each do |input|
    num_classes = input.strip.to_i
    inheritance = []

    num_classes.times do
      inheritance << ARGF.readline.strip.split.map(&:to_i).drop(1)
    end
    result = false
    (1..num_classes).each do |i|
      result = diamond_inheritance?(i, inheritance)
      if result
        break
      end
    end
    puts "Case ##{count += 1}: #{result ? "Yes" : "No"}"
  end
end
