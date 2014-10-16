require_relative '../../../lib/set-1/Problem 6/long-string-06'
require_relative '../../../lib/set-1/03-single-byte-xor-cypher'
require_relative '../../../lib/set-1/04-detect-single-char-xor'

string = @string.gsub("\n","").dup
packed = [@string].pack("m0")

blocks = []

until packed == ""
  chunk = packed.slice!(0,24)
  blocks << chunk
end

p blocks
p blocks.count

seperated_blocks = []
(24).times{ seperated_blocks << [""] }
p seperated_blocks

blocks.each_with_index do |block, index|
  # p index
  # p seperated_blocks[index][0]
  # p block.slice!(0)
  # p block
  p block
  x = 0
  until block == ""
    seperated_blocks[x][0] << block.slice!(x)
    x += 1
  end

end


p packed
p blocks
p seperated_blocks


# p detect_single_char_xor(seperated_blocks, ('a'..'z').to_a)