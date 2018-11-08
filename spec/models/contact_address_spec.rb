require 'rails_helper'

RSpec.describe ContactAddress, type: :model do
  let(:allowed_domain) { FactoryBot.create(:allowed_domain) }
  let(:user) { FactoryBot.create(:user, email: Faker::Internet.username + '@' + allowed_domain.domain) }
  let(:group) { FactoryBot.create(:group, user_id: user.id)}
  let(:contact) { FactoryBot.create(:contact, group_id: group.id) }
  subject { FactoryBot.create(:contact_address, contact_id: contact.id)}
  describe 'associations:' do
    it { is_expected.to belong_to(:contact) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:contact_type).scoped_to(:contact_id) }  
    it { should validate_uniqueness_of(:address).scoped_to(:contact_id) }  
  end

end
