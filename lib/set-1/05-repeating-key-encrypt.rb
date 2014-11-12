class BreakRepeatingKeyXOR

  def initialize(string, key)
    @string = string
    @key = key
  end

  def encrypt
    to_encrypt = @string.dup
    encrypted = ""
    x = 0

    until to_encrypt == ""
      xor = (to_encrypt.slice!(0).bytes.pop ^ @key[x].bytes.pop)
      encrypted << sprintf("%02x", xor)
      x == 2 ? x = 0 : x += 1
    end

    encrypted
  end

end
