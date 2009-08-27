require 'openssl'  
require 'base64'  

class PGP
  KEY_DIR = RAILS_ROOT + '/vendor/plugins/pgp/keys'
  
  def initialize(password, public_filename='public1024.pem', private_filename='private1024.pem')
    @password = password
    @public_key_file = KEY_DIR + '/' + public_filename
    @private_key_file = KEY_DIR + '/' + private_filename
  end
  
  def encrypt_url(string)
    CGI::escape(encrypt(string))
  end

  def decrypt_url(string)
    # rails automatically CGI::unescapes incoming URL params
    decrypt(string)
  end
  
  def encrypt(string)
    Base64.encode64(public_key.public_encrypt(string)).gsub("\n","")
  end
  
  def decrypt(string)
    private_key.private_decrypt(Base64.decode64(string))    
  end

  def public_key
    @public_key ||= load_key(@public_key_file)
  end
  
private  
  def private_key
    @private_key ||= load_key(@private_key_file)
  end

  def load_key(key_file)
    OpenSSL::PKey::RSA.new(File.read(key_file), @password)
  end
end
