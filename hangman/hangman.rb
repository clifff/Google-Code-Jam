ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  wordlist = []
  letter_orders = []

  nums = input.split.collect{|x| x.to_i}
  nums[0].times do
    wordlist << ARGF.readline.strip
  end
  #puts "Wordlist: #{wordlist.inspect}"
  nums[1].times do
    letter_orders << ARGF.readline.strip
  end
  #puts "Letter orders: #{letter_orders.inspect}"

  hard_words = []
  letter_orders.each do |order|
    order = order.split(//) # Create array of chars
    hardest_word = wordlist.first
    hardest_word_points = 0

    wordlist.each do |word|
      #puts "Testing word: #{word}"
      points = 0
      current_list = wordlist.select{ |x| x.size == word.size } # remove words that dont have the right number of spaces

      revealed = []
      order.each do |letter|
        raise 'think you fucked up' if current_list.empty?
        next if revealed.include? letter
        break if current_list.size == 1
        #puts "Checking letter: #{order[letter]}"
        search = current_list.select{ |x| x.index(letter) }
        if search.empty?
          next # will skip that letter because he knows nothing can be gained from it
        else
          if search.include?(word)
            revealed << letter
            current_list = current_list.select{ |x| x.index(letter) == word.index(letter) }
          else
            points += 1
          end
        end
      end

      #puts "#{word} is #{points} points"
      if points > hardest_word_points
        hardest_word = word
        hardest_word_points = points
      end
    end
    hard_words << hardest_word

  end

  puts "Case ##{count}: #{hard_words.join(' ')}"
end
