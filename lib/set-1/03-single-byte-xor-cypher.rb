# http://cryptopals.com/sets/1/challenges/3/

# given 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736

# given = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

class DecryptSingleXOR
  def initialize(hex_string, test_array)
    @hex = hex_string
    @test_array = test_array
  end

  def ranked_solutions
    with_count = []
    potential_solutions.each do |solution|
      with_count << [solution[0], (solution[1].scan(/[a-z]/).count - solution[1].scan(/\W/).count - solution[1].scan(/\d/).count), solution[1]]
    end
    with_count.sort_by { |solution| solution[1] }.reverse
  end

  private

  def potential_solutions
    possible_solutions = []
    @test_array.each do |letter|
      possible_solutions << [letter, fixed_xor(hex_decode, letter)]
    end
    possible_solutions
  end

  def fixed_xor(given, xor)
    empty = ""
    x = 0
    given.each_byte do |byte|
      empty << (byte ^ xor.to_s.bytes.pop)
      x += 1
    end
    empty
  end

  def hex_decode
    [@hex].pack("H*")
  end

end

# @encrypted = DecryptSingleXOR.new("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
# p @encrypted.ranked_solutions[0]
