class Contact < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :contact_numbers, dependent: :destroy
  has_many :contact_emails, dependent: :destroy
  has_many :contact_addresses, dependent: :destroy
  accepts_nested_attributes_for :contact_numbers, :contact_emails, :contact_addresses, allow_destroy: true
  validates_presence_of :name
  validate :has_number_or_email_or_address?
  
  private
  def has_number_or_email_or_address?
    if contact_numbers.size<1 && contact_emails.size<1 && contact_emails.size<1
      errors.add(:contact, "Should contain atleast one among number or email or address")
    end
  end
end
