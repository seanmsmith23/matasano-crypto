require "OpenSSL"
require "Base64"
require 'awesome_print'

class AESinECB

  def initialize
    @cipher = OpenSSL::Cipher.new('AES-128-ECB')
  end

  def decrypt(key, filepath, options={})
    raw = get_raw_content(filepath, options)
    decrypted = @cipher.decrypt
    decrypted.key = key
    decrypted.update(raw) + decrypted.final
  end

  private

  def get_raw_content(filepath, options)
    default = { encoding: :base_64 }
    contents = read_file(filepath)
    remove_encoding(contents, default.merge(options))
  end

  def read_file(filepath)
    opened = File.open(filepath)
    File.read(opened)
  end

  def remove_encoding(contents, options)
    encoding = options.fetch(:encoding)
    case encoding
      when :base_64
        base_64(contents)
      else
        raise "No encoding parameter provided"
    end
  end

  def base_64(contents)
    Base64.decode64(contents)
  end

end
