require 'pp'
key = {}

knowns = {
  'our language is impossible to understand' => 'ejp mysljylc kd kxveddknmc re jsicpdrysi',
  'there are twenty six factorial possibilities' => 'rbcpc ypc rtcsra dkh wyfrepkym veddknkmkrkcd',
  'so it is okay if you want to just give up' => 'de kr kd eoya kw aej tysr re ujdr lkgc jv',
  'a' => 'y',
  'o' => 'e',
  'z' => 'q'
}

knowns.each do |plain, crypted|
  plain.length.times do |i|
    c = plain[i]
    next if c.strip == ""
    key[c] = crypted[i]
  end
end

# Apparently that finds 25 of 26 comparisons. Figure out the last one..
missing_key, missing_value = nil
('a'..'z').each do |c|
  if !key.has_key?(c)
    missing_key = c
  end
  if !key.has_value?(c)
    missing_value = c
  end
end
key[missing_key] = missing_value

raise 'somethin bad happened, missing values' if key.size != ('a'..'z').to_a.size
inverted_key = key.invert

ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  translation = ""
  input.each_char do |c|
    if c.strip == ""
      translation += c
    else
      translation += inverted_key[c]
    end
  end
  puts "Case ##{count}: #{translation}"
end
