require 'rails_helper'

RSpec.describe 'Application', type: :request do

  describe 'GET /is_admin' do
    context 'when user logged in but not admin' do
        let(:allowed_domain){ create(:allowed_domain) }
        let(:user) { create(:user, email: Faker::Internet.username+'@'+allowed_domain.domain) }   
        let(:headers) { valid_headers }
        before { get '/is_admin', headers: headers }
        it 'returns boolean about admin role' do
            expect(json['is_admin']).to eq(false)
        end
    end

    context 'when user not logged in' do
        before { get '/is_admin' }
        it 'returns missing token' do
            expect(json['message']).to eq('Missing token')
        end 
    end

    context 'when user logged in and is admin' do
        let(:allowed_domain){ create(:allowed_domain) }
        let(:user) { create(:user_with_adminrole, email: Faker::Internet.username+'@'+allowed_domain.domain) }   
        let(:headers) { valid_headers }
        it 'return is_admin as true' do
            get '/is_admin', headers: headers
            expect(json['is_admin']).to eq(true)
        end
    end

    context 'when user logged in and is not admin' do
        let(:allowed_domain){ create(:allowed_domain) }
        let(:user) { create(:user, email: Faker::Internet.username+'@'+allowed_domain.domain) }   
        let(:headers) { valid_headers }
        it 'return is_admin as true' do
            get '/is_admin', headers: headers
            expect(json['is_admin']).to eq(false)
        end
    end
  end
    
end