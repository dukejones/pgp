
namespace :pgp do
  @bits = 1024
  @public_file_name = "vendor/plugins/pgp/lib/public#{@bits}.pem"
  @private_file_name = "vendor/plugins/pgp/lib/private#{@bits}.pem"

  task :generate_key_pair => [:generate_private_key, :extract_public_key]
  
  task :generate_private_key do
    `openssl genrsa -des3 -out #{@private_file_name} #{@bits}`
  end
  
  task :extract_public_key do
    `openssl rsa -in #{@private_file_name} -out #{@public_file_name} -outform PEM -pubout`
  end
end
