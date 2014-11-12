require_relative '../../lib/set-1/parse_string'
require_relative '../../lib/set-1/03-single-byte-xor-cypher'
require 'byebug'
require 'awesome_print'

class DetectSingleCharXOR

  def initialize(filepath, chars_array)
    @strings = ParseString.new(filepath).split_by_newline
    @chars = chars_array
  end

  def ranked_solutions
    possible_solutions.sort_by { |solution| solution[:score] }.reverse
  end

  private

  def possible_solutions
    possible_solutions = []
    @strings.each do |string|
      encrypted = DecryptSingleXOR.new(string, @chars)
      encrypted.ranked_solutions.each do |solution|
        possible_solutions << solution if solution[:score] > 5
      end
    end
    possible_solutions
  end

end