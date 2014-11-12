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

    @encrypted = DecryptSingleXOR.new(encrypted, ('A'..'z').to_a)

    expect(@encrypted.ranked_solutions[0][:result]).to eq("Cooking MC's like a pound of bacon")
    expect(@encrypted.ranked_solutions[0][:key]).to eq("X")
  end
end

describe DetectSingleCharXOR do
  it "should take a string and detect which character was used to encrypt it" do
    filepath = "/Users/seansmith/gSchoolWork/side-projects/matasano-crypto/lib/set-1/long-string"

    potential_chars = (0..9).to_a

    @detect = DetectSingleCharXOR.new(filepath, potential_chars)

    expect(@detect.ranked_solutions[0]).to eq({:key=>5, :score=>22, :result=>"Now that the party is jumping\n"})
  end
end

describe BreakRepeatingKeyXOR do
  it "should take a string to encrypt and a key, then use repeating XOR to encrypt the string" do
    string = "Burning 'em, if you ain't quick and nimble
I go crazy when I hear a cymbal"
    key = "ICE"

    @to_encrypt = BreakRepeatingKeyXOR.new(string, key)

    expect(@to_encrypt.encrypt).to eq("0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f")
  end
end

describe Hamming do
  it "should calculate the hamming distance between two strings" do
    string1 = "this is a test"
    string2 = "wokka wokka!!!"

    @hamming = Hamming.new(string1, string2)

    expect(@hamming.distance).to eq(37)
  end
end

describe ParseString do
  it "should split a long string into an array on the newlines" do
    filepath = "/Users/seansmith/gSchoolWork/side-projects/matasano-crypto/spec/test_string.rb"

    @file = ParseString.new(filepath)

    split_file = @file.split_by_newline

    expect(split_file[0]).to eq("hello there")
    expect(split_file[1]).to eq("you mofo")
    expect(split_file[2]).to eq("how are things")
  end
end

describe UnknownRepeatingKeyXOR do
  it "should decrypt a Base64 file that has been encrypted with repeating key XOR" do
    filepath = "/Users/seansmith/gSchoolWork/side-projects/matasano-crypto/lib/set-1/06-file"

    expect(UnknownRepeatingKeyXOR.new(filepath).decrypt).to eq("I'm back and I'm ringin' the bell \nA rockin' on the mike while the fly girls yell \nIn ecstasy in the back of me \nWell that's my DJ Deshay cuttin' all them Z's \nHittin' hard and the girlies goin' crazy \nVanilla's on the mike, man I'm not lazy. \n\nI'm lettin' my drug kick in \nIt controls my mouth and I begin \nTo just let it flow, let my concepts go \nMy posse's to the side yellin', Go Vanilla Go! \n\nSmooth 'cause that's the way I will be \nAnd if you don't give a damn, then \nWhy you starin' at me \nSo get off 'cause I control the stage \nThere's no dissin' allowed \nI'm in my own phase \nThe girlies sa y they love me and that is ok \nAnd I can dance better than any kid n' play \n\nStage 2 -- Yea the one ya' wanna listen to \nIt's off my head so let the beat play through \nSo I can funk it up and make it sound good \n1-2-3 Yo -- Knock on some wood \nFor good luck, I like my rhymes atrocious \nSupercalafragilisticexpialidocious \nI'm an effect and that you can bet \nI can take a fly girl and make her wet. \n\nI'm like Samson -- Samson to Delilah \nThere's no denyin', You can try to hang \nBut you'll keep tryin' to get my style \nOver and over, practice makes perfect \nBut not if you're a loafer. \n\nYou'll get nowhere, no place, no time, no girls \nSoon -- Oh my God, homebody, you probably eat \nSpaghetti with a spoon! Come on and say it! \n\nVIP. Vanilla Ice yep, yep, I'm comin' hard like a rhino \nIntoxicating so you stagger like a wino \nSo punks stop trying and girl stop cryin' \nVanilla Ice is sellin' and you people are buyin' \n'Cause why the freaks are jockin' like Crazy Glue \nMovin' and groovin' trying to sing along \nAll through the ghetto groovin' this here song \nNow you're amazed by the VIP posse. \n\nSteppin' so hard like a German Nazi \nStartled by the bases hittin' ground \nThere's no trippin' on mine, I'm just gettin' down \nSparkamatic, I'm hangin' tight like a fanatic \nYou trapped me once and I thought that \nYou might have it \nSo step down and lend me your ear \n'89 in my time! You, '90 is my year. \n\nYou're weakenin' fast, YO! and I can tell it \nYour body's gettin' hot, so, so I can smell it \nSo don't be mad and don't be sad \n'Cause the lyrics belong to ICE, You can call me Dad \nYou're pitchin' a fit, so step back and endure \nLet the witch doctor, Ice, do the dance to cure \nSo come up close and don't be square \nYou wanna battle me -- Anytime, anywhere \n\nYou thought that I was weak, Boy, you're dead wrong \nSo come on, everybody and sing this song \n\nSay -- Play that funky music Say, go white boy, go white boy go \nplay that funky music Go white boy, go white boy, go \nLay down and boogie and play that funky music till you die. \n\nPlay that funky music Come on, Come on, let me hear \nPlay that funky music white boy you say it, say it \nPlay that funky music A little louder now \nPlay that funky music, white boy Come on, Come on, Come on \nPlay that funky music \n")
  end
end

describe AESinECB do
  it "should decrypt a file that uses ECB encryption when given a key, file, and string encoding options" do
    filepath = "/Users/seansmith/gSchoolWork/side-projects/matasano-crypto/lib/set-1/07-file"
    key = "YELLOW SUBMARINE"

    @aes_in_ecb = AESinECB.new

    expect(@aes_in_ecb.decrypt(key, filepath)).to eq("I'm back and I'm ringin' the bell \nA rockin' on the mike while the fly girls yell \nIn ecstasy in the back of me \nWell that's my DJ Deshay cuttin' all them Z's \nHittin' hard and the girlies goin' crazy \nVanilla's on the mike, man I'm not lazy. \n\nI'm lettin' my drug kick in \nIt controls my mouth and I begin \nTo just let it flow, let my concepts go \nMy posse's to the side yellin', Go Vanilla Go! \n\nSmooth 'cause that's the way I will be \nAnd if you don't give a damn, then \nWhy you starin' at me \nSo get off 'cause I control the stage \nThere's no dissin' allowed \nI'm in my own phase \nThe girlies sa y they love me and that is ok \nAnd I can dance better than any kid n' play \n\nStage 2 -- Yea the one ya' wanna listen to \nIt's off my head so let the beat play through \nSo I can funk it up and make it sound good \n1-2-3 Yo -- Knock on some wood \nFor good luck, I like my rhymes atrocious \nSupercalafragilisticexpialidocious \nI'm an effect and that you can bet \nI can take a fly girl and make her wet. \n\nI'm like Samson -- Samson to Delilah \nThere's no denyin', You can try to hang \nBut you'll keep tryin' to get my style \nOver and over, practice makes perfect \nBut not if you're a loafer. \n\nYou'll get nowhere, no place, no time, no girls \nSoon -- Oh my God, homebody, you probably eat \nSpaghetti with a spoon! Come on and say it! \n\nVIP. Vanilla Ice yep, yep, I'm comin' hard like a rhino \nIntoxicating so you stagger like a wino \nSo punks stop trying and girl stop cryin' \nVanilla Ice is sellin' and you people are buyin' \n'Cause why the freaks are jockin' like Crazy Glue \nMovin' and groovin' trying to sing along \nAll through the ghetto groovin' this here song \nNow you're amazed by the VIP posse. \n\nSteppin' so hard like a German Nazi \nStartled by the bases hittin' ground \nThere's no trippin' on mine, I'm just gettin' down \nSparkamatic, I'm hangin' tight like a fanatic \nYou trapped me once and I thought that \nYou might have it \nSo step down and lend me your ear \n'89 in my time! You, '90 is my year. \n\nYou're weakenin' fast, YO! and I can tell it \nYour body's gettin' hot, so, so I can smell it \nSo don't be mad and don't be sad \n'Cause the lyrics belong to ICE, You can call me Dad \nYou're pitchin' a fit, so step back and endure \nLet the witch doctor, Ice, do the dance to cure \nSo come up close and don't be square \nYou wanna battle me -- Anytime, anywhere \n\nYou thought that I was weak, Boy, you're dead wrong \nSo come on, everybody and sing this song \n\nSay -- Play that funky music Say, go white boy, go white boy go \nplay that funky music Go white boy, go white boy, go \nLay down and boogie and play that funky music till you die. \n\nPlay that funky music Come on, Come on, let me hear \nPlay that funky music white boy you say it, say it \nPlay that funky music A little louder now \nPlay that funky music, white boy Come on, Come on, Come on \nPlay that funky music \n")
  end

end
