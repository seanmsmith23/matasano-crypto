# http://cryptopals.com/sets/1/challenges/3/

# given 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736

# given = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

class DecryptSingleXOR
  def initialize(hex_string)
    @hex = hex_string
  end

  def ranked_solutions
    with_count = []
    potential_solutions.each do |solution|
      with_count << [solution[0], (solution[1].scan(/[a-z]/).count - solution[1].scan(/\W/).count - solution[1].scan(/\d/).count), solution[1]]
    end
    with_count.sort_by { |solution| solution[1] }.reverse
  end

  private

  def letter_array
    ('A'..'z').to_a
  end

  def potential_solutions
    possible_solutions = []
    letter_array.each do |letter|
      possible_solutions << [letter, fixed_xor(hex_decode, letter)]
    end
    possible_solutions
  end

  def fixed_xor(given, xor)
    empty = ""
    x = 0
    given.each_byte do |byte|
      empty << (byte ^ xor.bytes.pop)
      x += 1
    end
    empty
  end

  def hex_decode
    [@hex].pack("H*")
  end

end

#
#
#
#
# caps = ('A'..'z').to_a
# # caps << ('A'..'Z').to_a
#
#
#
# possible_solutions = []
# with_count = []
#
# caps.each do |letter|
#   possible_solutions << [letter, fixed_xor(decoded, letter)]
# end
#
# p possible_solutions
#
#
#
# new = with_count.sort_by { |solution| solution[1] }.reverse
# p '*'*80
# p new
#
