# http://cryptopals.com/sets/1/challenges/3/

# given 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736

given = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

decoded = [given].pack("H*")

caps = ('A'..'z').to_a
# caps << ('A'..'Z').to_a

def fixed_xor(given, xor)
  empty = ""
  x = 0
  given.each_byte do |byte|
    empty << (byte ^ xor.bytes.pop)
    x += 1
  end
  empty
end

possible_solutions = []
with_count = []

caps.each do |letter|
  possible_solutions << [letter, fixed_xor(decoded, letter)]
end

p possible_solutions

possible_solutions.each do |solution|
  with_count << [solution[0], (solution[1].scan(/[a-z]/).count - solution[1].scan(/\W/).count - solution[1].scan(/\d/).count)]
end

new = with_count.sort_by { |solution| solution[1] }.reverse

p new





