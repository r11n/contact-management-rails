class Group < ApplicationRecord
  belongs_to :user
  has_many :contacts, dependent: :destroy
  validates_uniqueness_of :name,case_sensitive: false ,scope: :user_id
  validates_presence_of :name
end
