class ContactNumber < ApplicationRecord
  belongs_to :contact
  validates_uniqueness_of :type, :number, scope: :contact_id
end
