require 'rails_helper'

RSpec.describe AuthorizeApiRequest do

  let(:allowed_domain) { create(:allowed_domain) }
  let(:user) { create(:user, email: Faker::Internet.username + '@' + allowed_domain.domain) }  
  let(:header) { { 'Authorization' => token_generator(user.id) } }
  subject(:invalid_request_obj) { described_class.new({}) }
  subject(:request_obj) { described_class.new(header) }


 
  describe '#call' do   
    context 'when valid request' do
      it 'accepts the request' do
        result = request_obj.call
        expect(result).to eq(user)
      end
    end

    # returns error message when invalid request
    context 'when invalid request' do
    
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_obj) { described_class.new(header) }
        it 'handles JWT::DecodeError' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken,'Invalid token')
        end
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }    
        it 'raises ExceptionHandler::MissingToken error' do
          expect { request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken,'Invalid token')
        end
      end
     
    end
  end
end