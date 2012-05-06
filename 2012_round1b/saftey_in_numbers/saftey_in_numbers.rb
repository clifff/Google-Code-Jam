ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  num_contestants, *votes = input.split.map(&:to_i)
  x = 0
  votes.each{|v| x += v}
  answers = []
  totals = []
  num_contestants.times do |i|
    lowest_score = 100
    votes.each_with_index do |v, ind|
      if ind != i && v < lowest_score
        lowest_score = v
      end
    end
    needed = (2.0 / num_contestants) * lowest_score
    answer = (needed - votes[i]) / x
    answer = 0 if answer < 0
    answers << answer
    totals << votes[i] + answer * x
  end
  puts "Input: #{votes.inspect}"
  puts "Totals: #{totals.inspect}"

  answers = answers.collect{|a| (a*100).round(6)}
  puts "Case ##{count}: #{answers.join(" ")}"
end
