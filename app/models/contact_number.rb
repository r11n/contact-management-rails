class ContactNumber < ApplicationRecord
  belongs_to :contact
  validates_uniqueness_of :contact_type, :number, scope: :contact_id
end
