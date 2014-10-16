require_relative '../../set-1/Problem 6/long-string-06'
require_relative '../04-detect-single-char-xor'

class FindKeysize
  def initialize(string, min, max)
    @string = string
    @min = min
    @max = max
  end

  def estimate_keysize_length
    keysizes = create_keysizes(@min, @max)

    results = []

    keysizes.each do |keysize|
      results << potential_keysize(keysize)
    end

    results.sort_by{|result| result[0]}
  end

  private

  def potential_keysize(keysize)
    total_distance = 0
    one = generate_tests(keysize, @string, 0, 1)
    total_distance += hamming_dist(one[0], one[1])
    output = [total_distance/keysize.to_f, keysize]
  end

  def string
    @copied = @string.dup.gsub("\n","")
  end

  def hamming_dist(string1, string2)
    dup1 = string1.dup
    dup2 = string2.dup
    count = 0

    until dup1 == ""
      count += (dup1.slice!(0).bytes.pop ^ dup2.slice!(0).bytes.pop).to_s(2).count("1")
    end

    count
  end

  def generate_tests(keysize, string, start, finish)
    test = []

    test << string.slice(keysize*start,keysize)
    test << string.slice(keysize*finish,keysize)

    test
  end

  def create_keysizes(min, max)
    (min..max).to_a
  end

end

packed_string = [@string].pack("m0")

@new = FindKeysize.new(packed_string, 2, 40)
p @new.estimate_keysize_length

# p potential_keysize(keysizes[28])

# #
# distance = 0
# test = generate_tests(4, string)
# x = 0
#
# until x == test[0].length
#   distance += (test[0].bytes[x] ^ test[1].bytes[x]).to_s(2).count("1")/2
#   distance += (test[2].bytes[x] ^ test[3].bytes[x]).to_s(2).count("1")/2
#   x += 1
# end
# p distance/2
#
# p generate_tests(40, string)


