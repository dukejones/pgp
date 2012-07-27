This project is super old
=========================

This project is still online mainly for historical purposes.  It's for an outdated version of Rails, and you could roll your own in a few hours.

### The salient information is simply:

```ruby
# generate private key
`openssl genrsa -des3 -out #{@private_file_name} #{@bits}`

# extract_public_key
`openssl rsa -in #{@private_file_name} -out #{@public_file_name} -outform PEM -pubout`

require 'openssl'  
require 'base64'  

# Load public or private key files
OpenSSL::PKey::RSA.new(File.read(key_file), @password)

# Encrypt
Base64.encode64(public_key.public_encrypt(string)).gsub("\n","")

# Decrypt
private_key.private_decrypt(Base64.decode64(string))    
```



PGP
===

This is a very simple plugin for a simple algorithm that's often over-complicated.  It takes
only a few relatively simple steps, and you can be using strong PGP encryption.  

This plugin requires openssl to be installed.

Simply generate a key pair with the rake task (you may want to alter some of the params in the task),
and then use those key files in your program.  The relative size of the encrypted string will be 
proportional to the bit length of your keys.  

Enjoy!

~Duke

Example
-------

```ruby
`rake pgp:generate_key_pair`

p = PGP.new('pass')
p.public_key # just to see it

p.encrypt('A very secret string')
```


Copyright (c) 2009 Duke Jones, PGP Corporation, released under the MIT license
