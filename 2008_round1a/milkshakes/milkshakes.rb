class Customer
  attr_accessor :preferences

  # Take in an array of N flavors, 0 indicating unmalted, 1 malted
  def satisfied?(flavors)
    result = false
    preferences.each_slice(2) do |pref|
      result = (flavors[pref.first - 1] == pref.last)
      break if result
    end
    result
  end

  def malted_preference
    preferences.each_slice(2) do |pref|
      if pref.last == 1
        return pref.first
      end
    end
    false
  end
end

ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  num_flavors = input.strip.to_i
  num_customers = ARGF.readline.strip.to_i
  preferences = []
  available = Array.new(num_flavors, 0)
  customers = []
  num_customers.times do
    preferences = ARGF.readline.split.map(&:to_i).drop(1)
    c = Customer.new
    c.preferences = preferences
    customers << c
  end
  rerun = true
  while(rerun)
    rerun = false
    customers.each do |c|
      if !c.satisfied?(available)
        #If unsatisfied AND likes one malted flavor, malt that shit (no go back to 2)
        if malted_preference = c.malted_preference
          available[malted_preference - 1] = 1
          rerun = true
        # If they ONLY like unmalted and all those flavors have been malted, IMPOSSIBLE
        else
          "oh god no malt preference"
          available = "IMPOSSIBLE"
          rerun = false
          break
        end
      end
    end
  end
  pretty = if available.is_a?(Array)
    available.join(" ")
  else
    available
  end

  puts "Case ##{count}: #{pretty}"
end
