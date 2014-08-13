# http://cryptopals.com/sets/1/challenges/1/

class HexToBase64
  def initialize(hex_string)
    @hex = hex_string
  end

  def convert
    [[@hex].pack("H*")].pack("m0")
  end
end
