class ParseString

  attr_reader :contents

  def initialize(filepath)
    opened = File.open(filepath)
    @contents = File.read(opened)
  end

  def split_by_newline
    @contents.split("\n")
  end

end