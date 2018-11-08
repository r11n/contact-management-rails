require 'rails_helper'

RSpec.describe User, type: :model do
  let(:allowed_domain) { FactoryBot.create(:allowed_domain) }
  let(:user) { FactoryBot.create(:user, email: Faker::Internet.username + '@' + allowed_domain.domain) }
  subject { user }

  describe 'associations:' do
    it { is_expected.to have_many(:user_roles).dependent(:destroy) }
    it { is_expected.to have_many(:roles).through(:user_roles) }
    it { is_expected.to have_many(:groups).dependent(:destroy) }
    it { is_expected.to have_many(:contacts).dependent(:destroy) }
  end


  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:personal_identity_number) }
  end


  describe "class methods" do   
    it "is_admin? validation" do
        expect(user.is_admin?).to eq(false) 
    end
    it "encrytion of personal identity" do
      expect(user.personal_identity_number).to eq(Encrypter.encrypt user.plain_identity) 
    end
    it "decryption of personal identiy" do
      expect(user.plain_identity).to eq(user.decrypt_identity) 
    end
  end 
end

