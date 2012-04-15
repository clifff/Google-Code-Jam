def valid_scores? scores, expected_total
  # Total actually has to be right
  total = 0
  scores.each{ |s| total += s }
  return false unless expected_total == total

  # Scores must be between 0 and 10 inclusive
  return false if scores.any?{|s| !(0..10).include?(s) }

  scores.each do |s|
    return false if scores.any?{|x| (x - s).abs > 2}
  end

  true
end

def surprising_scores? scores
  scores.each do |s|
    return true if scores.any?{|x| (x - s).abs == 2}
  end
  false
end

# Given a score value, returns two boolean values
# - if the given score potentialy has a best result above best_score_threshhold
# - if the score is potentially above best_score_threshhold, is it surprising
def analysis_of_score score, best_score_threshhold
  # Determine baseline
  score = score.to_i
  temp = score
  first = (temp.to_f / 3).ceil
  temp -= first
  second = (temp.to_f / 2).ceil
  temp -= second
  third = temp

  # To make life easier, keep this list sorted biggest to smallest
  scores = [first, second, third].sort.reverse

  if !valid_scores?(scores, score)
    raise "FUCK"
  end

  # Check the easy case first
  if scores.max >= best_score_threshhold
    return true, surprising_scores?(scores)
  end

  temp = scores
  temp[0] += 1
  temp[1] -= 1

  if valid_scores?(temp, score) && temp.max >= best_score_threshhold
    return true, surprising_scores?(temp)
  end

  return false, false
end

# So as not to mess w/ test.rb
if __FILE__==$0
  ARGF.readline
  count = 0
  ARGF.each do |input|
    count += 1
    input = input.split.collect{|x| x.to_i}
    # Drop the number of dancers, don't really care
    input.shift
    actual_surprising = input.shift
    score_threshhold = input.shift
    scores = input

    definite_above = 0
    surprising_above = 0

    scores.each do |score|
      above_threshold, was_surprising = analysis_of_score(score, score_threshhold)
      next unless above_threshold
      if was_surprising
        surprising_above += 1
      else
        definite_above += 1
      end
    end
    if surprising_above > actual_surprising
      surprising_above = actual_surprising
    end
    result = definite_above + surprising_above

    puts "Case ##{count}: #{result}"
  end
end
