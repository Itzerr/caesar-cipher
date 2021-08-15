def substrings(word, dictionary)
    word = word.downcase
    dictionary.reduce(Hash.new(0)) do |substrings, substring|
        found = word.scan(/#{substring}/).length
        substrings[substring] = found if found > 0
        substrings
    end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)