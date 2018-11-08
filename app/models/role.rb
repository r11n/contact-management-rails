class Role < ApplicationRecord
    has_many :user_roles, dependent: :destroy
    has_many :users, through: :user_roles

    validates_uniqueness_of :name, case_sensitive: false
    validates_presence_of :name
end
