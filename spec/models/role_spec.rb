require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { FactoryBot.create(:role) }
  describe 'association methods:' do
    it { is_expected.to have_many(:user_roles).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:user_roles) }    
  end

  describe "validations" do
    # subject { FactoryBot.create(:role) }    
    it { should validate_presence_of(:name) }   
    it { should validate_uniqueness_of(:name).case_insensitive }  
  end
  
end
