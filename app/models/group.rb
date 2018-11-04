class Group < ApplicationRecord
  belongs_to :user
  has_many :contacts, dependent: :destroy
end
