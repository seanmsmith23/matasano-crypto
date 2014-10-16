require_relative '../../lib/set-1/ParseString'
require_relative '../../lib/set-1/03-single-byte-xor-cypher'
require 'byebug'
require 'awesome_print'

class DetectSingleCharXOR

  def initialize(filepath, chars_array)
    @strings = ParseString.new(filepath).split_by_newline
    @chars = chars_array
  end

  def ranked_solutions
    possible_solutions.sort_by { |solution| solution[1] }.reverse
  end

  private

  def possible_solutions
    possible_solutions = []
    @strings.each do |string|
      encrypted = DecryptSingleXOR.new(string, @chars)
      encrypted.ranked_solutions.each do |solution|
        possible_solutions << solution if solution[1] > 5
      end
    end
    possible_solutions
  end

end

#
# # string = @string.dup
# array = ParseString.new("/Users/seansmith/gSchoolWork/side-projects/matasano-crypto/lib/set-1/long-string").split_by_newline
#
# def  detect_single_char_xor(array_of_strings, range)
#   array = array_of_strings
#   possible_solutions = []
#
#   array.each do |string|
#     @encrypted = DecryptSingleXOR.new(string, range)
#     @encrypted.ranked_solutions.each do |solution|
#       possible_solutions << solution if solution[1] > 5
#     end
#   end
#
#   possible_solutions.sort_by { |solution| solution[1] }.reverse
# end
#
# ap detect_single_char_xor(array, (0..9).to_a)
