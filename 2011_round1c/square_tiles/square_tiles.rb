def adjacent_positions(y,x)
  [[x+1,y],[x,y+1],[x+1,y+1]]
end

def convert_matrix(matrix)
  matrix.each_with_index do |line, y|
    while x = matrix[y].index("#")
      if adjacent_positions(x,y).all?{|p| matrix[p.first] && matrix[p.first][p.last] == "#"}
        matrix[y][x] = "/"
        matrix[y+1][x] = "\\"
        matrix[y][x+1] = "\\"
        matrix[y+1][x+1] = "/"
      else
        return "Impossible"
      end
    end
  end
  return matrix
end

ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  x, y = input.split.map(&:to_i)
  matrix = []
  x.times do |i|
    matrix << ARGF.readline.strip.split("")
  end
  result = convert_matrix(matrix)
  puts "Case ##{count}:"
  if result.is_a?(String)
    puts result
  else
    result.each{|l| puts l.join}
  end
end
