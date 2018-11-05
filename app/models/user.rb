class User < ApplicationRecord
    has_secure_password

    validates_uniqueness_of :email, :personal_identity_number
    validates_presence_of :email, :name, :personal_identity_number

    has_many :groups, dependent: :destroy
    has_many :contacts, dependent: :destroy
    has_many :user_roles, dependent: :destroy
    has_many :roles,through: :user_roles

    attr_accessor :plain_identity
    before_validation :encrypt_identity
    validate :email_in_allowed_domains?
    
    def is_admin?
        roles.any?{|k| k.name == 'admin'}
    end
    
    def decrypt_identity
        if personal_identity_number.present?
            self.plain_identity = Encrypter.decrypt personal_identity_number
            return plain_identity
        end
    end
    private

    def email_in_allowed_domains?
        if self.new_record?
            # getting user entered domain
            user_domain = email.split('@')[1]
            # adding error if user entered domain is not present in allowed_domains
            errors.add(:email, "Email Domain is not allowed") if !AllowedDomain.all.pluck(:domain).include?(user_domain)
        end
    end

    def encrypt_identity
        if plain_identity.present?
            self.personal_identity_number = Encrypter.encrypt plain_identity
        end
    end

end
