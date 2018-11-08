require 'rails_helper'
require 'faker'
RSpec.describe AuthenticateUser do
  let(:allowed_domain) { create(:allowed_domain) }
  let(:user) { create(:user, email: Faker::Internet.username + '@' + allowed_domain.domain) }  
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }  
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  # Test suite for AuthenticateUser#call
  describe '#call' do
    # return token when valid request
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj
        expect(token).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request
    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,'Invalid Credentials')
      end
    end
  end
end