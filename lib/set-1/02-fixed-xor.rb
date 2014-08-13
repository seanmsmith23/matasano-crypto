# http://cryptopals.com/sets/1/challenges/2/

class FixedXOR

  def initialize(to_encrypt, xor_key)
    @to_encrypt = to_encrypt
    @xor_key = xor_key
  end

  def hex_to_binary(hex_string)
    [hex_string].pack("H*")
  end

  def encrypt
    to_encrypt = hex_to_binary(@to_encrypt)
    key = hex_to_binary(@xor_key)

    empty = ""
    x = 0

    to_encrypt.each_byte do |byte|
      empty << (byte ^ key[x].bytes.pop).to_s(16)
      x += 1
    end
    empty
  end

end
