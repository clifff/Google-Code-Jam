class Other
  attr_accessor :times, :positions

  def initialize
    @times = []
    @positions = []
  end

  def add_input(input)
    @times << input.first
    @positions << input.last
  end

  def index_at_time(time)
    index = 0
    @times.each_with_index do |t,i|
      # think we never want the last position?
      next if i == (@times.size - 1)
      if t <= time && i > index
        index = i
      end
    end
    index
  end

  def speed_at_time(time)
    index = index_at_time(time)
    (@positions[index + 1] - @positions[index]) / (@times[index + 1] - @times[index])
  end

  def position_at_time(time)
    index = index_at_time(time)
    current_rate = speed_at_time(time)
    @positions[index] + (time - @times[index])*current_rate
  end

end

def solve_quad(a,b,c)
  first = (-b + (Math.sqrt( b*b - 4*a*c ))) / 2*a
  second = (-b - (Math.sqrt( b*b - 4*a*c ))) / 2*a
  if first < 0
    second
  else
    first
  end
end

if __FILE__ == $0
  ARGF.readline
  count = 0
  ARGF.each do |input|
    puts "Case ##{count += 1}:"
    distance, n, a = input.strip.split.map(&:to_f)
    n = n.to_i
    a = a.to_i
    other = Other.new
    n.times do |i|
      other.add_input(ARGF.readline.strip.split.map(&:to_f))
    end
    accelerations = ARGF.readline.strip.split.map(&:to_f)
    unit = 1.0 / 1000000
    accelerations.each do |accel|
      our_pos = 0.0
      our_speed = 0.0
      behind_other = false
      time = 0.0
      other.times.each_with_index do |t, i|
        other_pos = other.position_at_time(time)

        # Special end case if its last time step
        if i == (other.times.size - 1)
          # W/ no more changes, figure out when we hit the end
          other_speed = other.speed_at_time(t)
          other_finish = ((distance - other_pos) / other_speed ) + other.times[i-1]
          puts "Other fin: #{other_finish}"

          our_finish = solve_quad(0.5*accel, our_speed, -1*distance)
          if our_finish <= other_finish
            puts "STUCK"
            our_finish = other_finish
          end
          puts our_finish
          break
        # General case
        else
          our_pos = our_speed * other.times[i+1] + 0.5 * accel * other.times[i+1]*other.times[i+1]
        end

        # Possible outcomes
        # - other car is always in front of, just use equation
        if our_pos >= other_pos
          puts "we caught up!"
          our_pos = other_pos
          our_speed = other.speed_at_time(time)
        else
          our_speed = our_speed + accel*other.times[t+1]
          # Cool! do nother, move on to next
        end
      end
    end
  end
end
