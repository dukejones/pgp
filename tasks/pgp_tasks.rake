
namespace :pgp do
  KEY_DIR = 'vendor/plugins/pgp/keys'

  @bits = 1024
  @public_file_name = KEY_DIR + "/public#{@bits}.pem"
  @private_file_name = KEY_DIR + "/private#{@bits}.pem"

  task :generate_key_pair => [:generate_private_key, :extract_public_key]
  
  task :generate_private_key do
    `openssl genrsa -des3 -out #{@private_file_name} #{@bits}`
  end
  
  task :extract_public_key do
    `openssl rsa -in #{@private_file_name} -out #{@public_file_name} -outform PEM -pubout`
  end
end
