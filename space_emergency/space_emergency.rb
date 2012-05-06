def sum_up_to_index(arr, i)
  s = 0
  i.times do
    s += (arr[i] || 0)
  end
  s
end

ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  max_boosters, time_to_create, num_stars, c, *dist = input.split.map(&:to_i)
  distances = []
  booster_positions = []
  num_stars.times do |i|
    distances << dist[i % dist.size]
  end

  # Figure out the positions to start bulding boosters at
  boosters = distances.clone
  arr = []
  boosters.each_with_index{|x,i| arr << [x,i]}
  boosters = arr.sort{|x,y| y.first <=> x.first}.first(max_boosters)
  puts "booster positions: #{boosters.inspect}"

  ticks = 0
  traveled = 0
  while true
    ticks += 1

    # Adjust distances if we just finished boosters
    if ticks == time_to_create
      puts "MAKING THESE BOOSTERS: #{boosters.inspect} at time #{ticks}"
      boosters.each do |b|
        distances.size.times do |i|
          next unless i % b.last == 0
          distances[b.last] /= 2
        end
      end
    end
    if i = distances.detect{|x| x > 0}
      distances[distances.index(i)] -= 0.5
    else
      break
    end
  end
  puts ticks

  # After 4 hours, has travaled 2, distance goes from 10 to 5, will take 6
end
