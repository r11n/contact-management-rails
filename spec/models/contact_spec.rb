require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:allowed_domain) { FactoryBot.create(:allowed_domain) }
  let(:user) { FactoryBot.create(:user, email: Faker::Internet.username + '@' + allowed_domain.domain) }
  let(:group) { FactoryBot.create(:group, user_id: user.id)}
  let(:contact){FactoryBot.create(:contact, group_id: group.id)}
  subject { contact }
  describe 'associations:' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:group) }
    it { is_expected.to have_many(:contact_numbers) }
    it { is_expected.to have_many(:contact_emails) }
    it { is_expected.to have_many(:contact_addresses) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }   
  end

end
