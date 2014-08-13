require "spec_helper"

describe HexToBase64 do
  it "should convert a Hex string into Base64" do
    hex_string = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

    @converter = HexToBase64.new(hex_string)

    expect(@converter.convert).to eq("SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t")
  end
end

describe FixedXOR do
  it "should take a hex string and a hex string of equal length (as key) and encrypt with XOR" do
    hex = "1c0111001f010100061a024b53535009181c"
    key = "686974207468652062756c6c277320657965"

    @xor = FixedXOR.new(hex, key)

    expect(@xor.encrypt).to eq("746865206b696420646f6e277420706c6179")
  end
end

describe DecryptSingleXOR do
  it "should take an encrypted string (hex) and decrypt it assuming the key is a single letter" do
    encrypted = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

    @encrypted = DecryptSingleXOR.new(encrypted)

    expect(@encrypted.ranked_solutions[0][0]).to eq("X")
    expect(@encrypted.ranked_solutions[0][2]).to eq("Cooking MC's like a pound of bacon")

  end
end
