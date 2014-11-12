require "OpenSSL"
require "Base64"
require 'awesome_print'

filepath = "/Users/seansmith/gSchoolWork/side-projects/matasano-crypto/lib/set-1/07-file"

opened = File.open(filepath)
read = File.read(opened)

base = Base64.decode64(read)

cipher = OpenSSL::Cipher.new('AES-128-ECB')

decrypted = cipher.decrypt
decrypted.key = "YELLOW SUBMARINE"
ap decrypted.update(base) + decrypted.final
