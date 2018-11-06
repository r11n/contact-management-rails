class ContactEmail < ApplicationRecord
  belongs_to :contact
  validates_uniqueness_of :contact_type, :email, scope: :contact_id
end
