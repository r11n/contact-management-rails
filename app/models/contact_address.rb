class ContactAddress < ApplicationRecord
  belongs_to :contact
  validates_uniqueness_of :contact_type, :address, scope: :contact_id
end
