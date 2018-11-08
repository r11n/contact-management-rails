require 'rails_helper'

RSpec.describe AllowedDomain, type: :model do
  subject { FactoryBot.create(:allowed_domain) }
  
  describe "validations" do
    it { should validate_uniqueness_of(:domain) }  
    it { should validate_presence_of(:domain) }  
  end

end
