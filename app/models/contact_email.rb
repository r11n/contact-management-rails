class ContactEmail < ApplicationRecord
  belongs_to :contact
  validates_uniqueness_of :type, :email, scope: :contact_id
end
