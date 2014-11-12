require_relative '03-single-byte-xor-cypher'
require_relative 'parse_string'
require_relative 'hamming'
require 'base64'

class UnknownRepeatingKeyXOR

  def initialize(filepath)
    @contents = ParseString.new(filepath).split_by_newline
    @bytes = decode_and_join.bytes
  end

  def decrypt
    keysize = estimate_potential_keysize[0][:keysize]
    transposed = transpose_blocks(keysize)
    key = get_key(transposed)
    repeating_key_xor_decryption(key)
  end

  private

  def repeating_key_xor_decryption(key)
    split_key = key.split('')
    x = 0
    final = ""
    until @bytes == []
      final << [(split_key[x].bytes.pop ^ @bytes.shift)].pack("C*")
      x < split_key.length - 1 ? x += 1 : x = 0
    end
    final
  end

  def estimate_potential_keysize
    potential_keysizes.map do |keysize|
      hamming_distance_for(keysize)
    end.sort_by{ |guess| guess[:hamming] }
  end

  def potential_keysizes
    (2..40).to_a
  end

  def hamming_distance_for(keysize)
    starting = 0
    distances = []
    until (starting+(keysize*2)) >= @bytes.length
      first = @bytes[starting...(starting+keysize)]
      second = @bytes[starting+(keysize)...starting+(keysize*2)]
      starting += keysize*2
      current_chunk = {first: first, second: second}
      distances << hamming(current_chunk)/keysize
    end
    average = average_distances(distances)
    {hamming: average, keysize: keysize}
  end

  def hamming(chunks)
    count = 0
    chunks[:first].each_with_index do |byte, index|
      first = byte
      second = chunks[:second][index]
      count += (first ^ second).to_s(2).count("1")
    end
    count
  end

  def decode_and_join
    decode_base_64(@contents.join)
  end

  def decode_base_64(string)
    Base64.decode64(string)
  end

  def average_distances(distances)
    distances.inject{ |sum, el| sum + el }.to_f / distances.size
  end

  def transpose_blocks(keysize)
    transposed = []
    (keysize).times{ transposed << [] }
    x = 0
    @bytes.each do |byte|
      transposed[x] << byte
      x < keysize - 1 ? x += 1 : x = 0
    end
    transposed
  end

  def build_hex_string(bytes)
    string = ""
    bytes.each do |byte|
      string << [byte].pack("C*")
    end
    string.unpack("H*").first
  end

  def get_character(bytes)
    possible = ("\x0".."\x7F").to_a
    char = DecryptSingleXOR.new(build_hex_string(bytes), possible)
    char.ranked_solutions[0][:key]
  end

  def get_key(transposed_bytes)
    key = ""
    transposed_bytes.each do |bytes|
      key << get_character(bytes)
    end
    key
  end

end