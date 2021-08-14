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

print :"Text: "
string = gets
print :"Shift Factor: "
shift_factor = gets.to_i
puts caesar_cipher(string, shift_factor)