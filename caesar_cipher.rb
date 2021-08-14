def wrap_number(number, min, max)
    min + (number - min) % (max - min + 1)
end

def shift_character(char, shift_factor)
    char_ord = char.ord
    if char_ord.between?(65, 90)
        wrap_number(char_ord + shift_factor, 65, 90).chr
    elsif char_ord.between?(97, 122)
        wrap_number(char_ord + shift_factor, 97, 122).chr
    else
        char
    end
end

def caesar_cipher(string, shift_factor)
    char_map = string.chars.map do |char|
        shift_character(char, shift_factor)
    end
    char_map.join('')
end

puts caesar_cipher("What a string!", 5)
#puts caesar_cipher("abcABC", -1)
#puts add_and_wrap(10, 1, 1, 10);