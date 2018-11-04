class Encrypter
    # encrypts the plain text
    def self.encrypt(plain_text)
        cipher = OpenSSL::Cipher.new 'AES-128-CBC'
        cipher.encrypt
        pwd = Rails.application.secrets.secret_key_base[0..32]
        iv = Rails.application.secrets.iv
        salt = Rails.application.secrets.salt
        iter = 20000
        cipher.iv = iv
        key_len = cipher.key_len
        digest = OpenSSL::Digest::SHA256.new
        key = OpenSSL::PKCS5.pbkdf2_hmac(pwd, salt, iter, key_len, digest)
        cipher.key = key
        encrypted = cipher.update plain_text
        encrypted << cipher.final
        encrypted
    end

    def self.decrypt(encrypted_text)
        cipher = OpenSSL::Cipher.new 'AES-128-CBC'
        cipher.decrypt
        pwd = Rails.application.secrets.secret_key_base[0..32]
        iv = Rails.application.secrets.iv
        salt = Rails.application.secrets.salt
        iter = 20000
        cipher.iv = iv
        key_len = cipher.key_len
        digest = OpenSSL::Digest::SHA256.new
        key = OpenSSL::PKCS5.pbkdf2_hmac(pwd, salt, iter, key_len, digest)
        cipher.key = key
        decrypted = cipher.update encrypted_text
        decrypted << cipher.final
        decrypted
    end
end