class User < ApplicationRecord
    has_secure_password

    validates_uniqueness_of :email, :personal_identity_number
    validates_presence_of :email, :name, :personal_identity_number

    has_many :groups, dependent: :destroy
    has_many :contacts, dependent: :destroy

    attr_accessor :plain_identity
    before_validation :encrypt_identity

    private
    def encrypt_identity
        if plain_identity.present?
            personal_identity_number = Encrypter.encrypt plain_identity
        end
    end

    def decrypt_identity
        if personal_identity_number.present?
            plain_identity = Encrypter.decrypt personal_identity_number
            return plain_identity
        end
    end
end
