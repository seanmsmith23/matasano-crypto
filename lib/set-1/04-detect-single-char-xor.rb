require_relative '../set-1/long-string'
require_relative '../../lib/set-1/03-single-byte-xor-cypher'

string = @string.dup
array = string.split("\n")

def  detect_single_char_xor(array_of_strings, range)
  array = array_of_strings
  possible_solutions = []

  array.each do |string|
    @encrypted = DecryptSingleXOR.new(string, range)
    @encrypted.ranked_solutions.each do |solution|
      possible_solutions << solution if solution[1] > 5
    end
  end

  possible_solutions.sort_by { |solution| solution[1] }.reverse
end

# p detect_single_char_xor(array, (0..9).to_a)
