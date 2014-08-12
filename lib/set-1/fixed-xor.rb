# http://cryptopals.com/sets/1/challenges/2/

# given: 1c0111001f010100061a024b53535009181c

# when xor'd: 686974207468652062756c6c277320657965

# then: 746865206b696420646f6e277420706c6179

given = "1c0111001f010100061a024b53535009181c"
xor = "686974207468652062756c6c277320657965"

decoded = [given].pack("H*")
xor_decoded = [xor].pack("H*")

def fixed_xor(given, xor)
  empty = ""
  x = 0
  given.each_byte do |byte|
    empty << (byte ^ xor[x].bytes.pop).to_s(16)
    x += 1
  end
  empty
end

p fixed_xor(decoded, xor_decoded)
