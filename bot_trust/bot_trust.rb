# Look at current move and position
# If have to move, spend the turn doing that
# If at the button AND sequence.first is your move, remove from both sequeneces

def do_turn(robot_sequence, total_sequence, robot_position, pushed) 
  return pushed, robot_position if robot_sequence.empty?

  desired_position = robot_sequence.first.split.last.to_i
  if robot_position != desired_position
    if desired_position > robot_position
      robot_position += 1
    else
      robot_position -= 1
    end
    #puts "Moved to: #{robot_position}. Want to be at #{desired_position}"
  # Only make the move if it is in sequence
  elsif robot_sequence.first == total_sequence.first && (!pushed)
    #puts "Pushing button at #{robot_position}!"
    robot_sequence.shift
    pushed = true
  end
  return pushed, robot_position
end

ARGF.readline
count = 0
ARGF.each do |input|
  split_input = input.split(/(^\d+ )/)
  buttons = split_input[1].to_i

  sequence = split_input[2].split(/(\w \d+ )/).reject{|x| x.empty? }.collect{ |x| x.strip }
  blue_sequence = sequence.select{ |x| x[0].chr == "B" }.collect{ |x| x.strip }
  orange_sequence = sequence.select{ |x| x[0].chr == "O" }.collect{ |x| x.strip }

  raise 'error parsing sequence' if buttons != sequence.size
  count += 1
  o_position = 1
  b_position = 1
  seconds = 0
  while not sequence.empty?
    seconds += 1
    button_pushed = false
    button_pushed, o_position = do_turn(orange_sequence, sequence, o_position, button_pushed)
    button_pushed, b_position = do_turn(blue_sequence, sequence, b_position, button_pushed)
    if button_pushed
      sequence.shift
    end
  end
  puts "Case ##{count}: #{seconds}"
end
