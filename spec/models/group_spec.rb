require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:allowed_domain) { FactoryBot.create(:allowed_domain) }
  let(:user) { FactoryBot.create(:user, email: Faker::Internet.username + '@' + allowed_domain.domain) }
  subject { FactoryBot.create(:group, user_id: user.id)}
  describe 'associations:' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:contacts) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }   
    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:user_id) }  
  end

end
