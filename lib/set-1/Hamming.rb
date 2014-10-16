class Hamming

  attr_reader :count

  def initialize(string1, string2)
    @string1 = string1
    @string2 = string2
    @count = 0
  end

  def distance
    until @string1 == ""
      @count += (@string1.slice!(0).bytes.pop ^ @string2.slice!(0).bytes.pop).to_s(2).count("1")
    end
    @count
  end

end