require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Authentication test suite
  let(:allowed_domain){ create(:allowed_domain) }
  describe 'POST /auth/login' do
    let!(:user) { create(:user, email: Faker::Internet.username+'@'+allowed_domain.domain) }   
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {      
        user: {
          email: user.email,
          password: user.password
        }       
      }.to_json
    end
    let(:invalid_credentials) do
      {
        user: {
          email: Faker::Internet.email,
          password: Faker::Internet.password
        }      
      }.to_json
    end  

    # returns auth token when request is valid
    context 'When valid credentials' do
      before { post '/auth/login', params: valid_credentials, headers: headers }
      it 'returns an authentication token' do       
        expect(json['auth_token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'When invalid credentials' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }
      it 'returns a failure message' do
        expect(json['message']).to match('Invalid Credentials')
      end
    end

  end

  describe 'POST /auth/signup' do
    let(:headers) { invalid_headers }
    let(:password) { Faker::Internet.password }
    let(:valid_signup) do
        {
            user: {
                name: Faker::Name.name,
                email: Faker::Internet.username + '@' + allowed_domain.domain,
                password: password,
                password_confirmation: password,
                plain_identity: Faker::IDNumber.valid
            }
        }.to_json
    end
    let(:invalid_email) do
        {
            user: {
                name: Faker::Name.name,
                email: Faker::Internet.email,
                password: password,
                password_confirmation: password,
                plain_identity: Faker::IDNumber.valid
            }
        }.to_json
    end
    let(:invalid_identity) do
        {
            user: {
                name: Faker::Name.name,
                email: Faker::Internet.username + '@' + allowed_domain.domain,
                password: password,
                password_confirmation: password,
                plain_identity: nil
            }
        }.to_json
    end
    let(:password_mismatch) do
        {
            user: {
                name: Faker::Name.name,
                email: Faker::Internet.username + '@' + allowed_domain.domain,
                password: password,
                password_confirmation: Faker::Internet.password,
                plain_identity: Faker::IDNumber.valid
            }
        }.to_json
    end
    let(:invalid_name) do
        {
            user: {
                name: nil,
                email: Faker::Internet.username + '@' + allowed_domain.domain,
                password: password,
                password_confirmation: password,
                plain_identity: Faker::IDNumber.valid
            }
        }.to_json
    end

    # returns auth token when request is valid
    context 'When valid details' do
        before { post '/auth/signup', params: valid_signup, headers: headers }
        it 'returns an authentication token' do       
          expect(json['auth_token']).not_to be_nil
        end
    end
  
      # returns failure message when request is invalid
    context 'When invalid email' do
        before { post '/auth/signup', params: invalid_email, headers: headers }
        it 'returns a failure message' do
            expect(json['email']).to match(['Email Domain is not allowed'])
        end
    end

    context 'When invalid identity' do
        before { post '/auth/signup', params: invalid_identity, headers: headers }
        it 'returns a failure message' do
            expect(json['personal_identity_number']).to match(["can't be blank"])
        end
    end

    context 'When password mismatch' do
        before { post '/auth/signup', params: password_mismatch, headers: headers }
        it 'returns a failure message' do
            expect(json['password_confirmation']).to match(["doesn't match Password"])
        end
    end

    context 'When invalid name' do
        before { post '/auth/signup', params: invalid_name, headers: headers }
        it 'returns a failure message' do
            expect(json['name']).to match(["can't be blank"])
        end
    end
  end
end