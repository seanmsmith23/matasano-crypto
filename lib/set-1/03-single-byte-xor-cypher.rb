require 'awesome_print'
require 'byebug'

# http://cryptopals.com/sets/1/challenges/3/

class DecryptSingleXOR

  def initialize(hex_string, test_array)
    @hex = hex_decode(hex_string)
    @test_array = test_array
  end

  def ranked_solutions
    scored_solutions.sort_by { |solution| solution[:score] }.reverse
  end

  def scored_solutions
    potential_solutions.map do |solution|
      {key: solution[:key], score: score(solution), result: solution[:result]}
    end
  end

  def potential_solutions
    @test_array.map do |letter|
      {key: letter, result: fixed_xor(@hex, letter)}
    end
  end

  private

  def fixed_xor(given_string, xor)
    empty = ""
    given_string.each_byte do |byte|
      empty << xor_against(byte, xor)
    end
    empty
  end

  def hex_decode(hex_string)
    [hex_string].pack("H*")
  end

  def xor_against(byte, char_to_xor)
    byte ^ char_to_xor.to_s.bytes.pop
  end

  def score(solution)
    (solution[:result].scan(/[a-z]/).count + solution[:result].scan(/[ ]/).count - solution[:result].scan(/\W/).count - solution[:result].scan(/\d/).count)
  end

end