require_relative '../set-1/long-string'
require_relative '../../lib/set-1/03-single-byte-xor-cypher'

copied = @string.dup
array = copied.split("\n")

possible_solutions = []

array.each do |string|
  @encrypted = DecryptSingleXOR.new(string, (1..9).to_a)
  @encrypted.ranked_solutions.each do |solution|
    possible_solutions << solution if solution[1] > 5
  end
end

p possible_solutions.sort_by { |solution| solution[1] }.reverse