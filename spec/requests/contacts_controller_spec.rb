require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
    let(:allowed_domain){ create(:allowed_domain) }
    let(:user) { create(:user_with_grps, email: Faker::Internet.username+'@'+allowed_domain.domain) }   
    let(:other_user) { create(:user_with_grps, email: Faker::Internet.username+'@'+allowed_domain.domain) }   
    let(:headers) { valid_headers }
    let(:contacts) { create_list(:contact, 10,group_id: user.groups.first.id) }
    let(:other_contacts) { create_list(:contact, 10,group_id: other_user.groups.first.id) }

    context 'GET /groups/:group_id/contacts #index' do
        it 'user not logged in' do
            get "/groups/#{user.groups.first.id}/contacts"
            expect(json['message']).to eq('Missing token')
        end
        it 'user logged in gets his contacts if group status is active' do
            user.reload
            get "/groups/#{user.groups.first.id}/contacts", headers: headers
            expect(response.status).to eq(user.groups.first.status ? 200 : 404)
        end

        it 'user logged in should not get other user contacts' do
            get "/groups/#{other_user.groups.first.id}/contacts", headers: headers
            expect(response.status).to eq(404)
        end
    end

    context 'POST /groups/:group_id/contacts #create' do
        let(:attrs) { {contact_numbers_attributes: [{contact_type: Faker::Types.rb_string, number: Faker::PhoneNumber.cell_phone }]} }
        it 'user not logged in' do
            post "/groups/#{user.groups.first.id}/contacts", params: {contact: build(:contact, group_id: user.groups.first.id).attributes}.to_json
            expect(json['message']).to eq('Missing token')
        end 

        it 'user logged in creates new contact(in his group)' do
            post "/groups/#{user.groups.first.id}/contacts", headers: headers, params: {contact: build(:contact, group_id: user.groups.first.id).attributes.merge(attrs)}.to_json
            expect(response.status).to eq(user.groups.first.status ? 201 : 404)
        end

        it 'user logged in should not be able to create new contact other users group' do
            post "/groups/#{other_user.groups.first.id}/contacts", headers: headers, params: {contact: build(:contact, group_id: user.groups.first.id).attributes}.to_json
            expect(response.status).to eq(404)
        end
    end

    context 'GET /groups/:group_id/contacts/:id #show' do
        it 'user not logged in' do
            get "/groups/#{user.groups.first.id}/contacts/#{contacts.first.id}"
            expect(json['message']).to eq('Missing token')
        end 

        it 'user logged in creates new contact(in his group)' do
            get "/groups/#{user.groups.first.id}/contacts/#{contacts.first.id}", headers: headers
            expect(response.status).to eq(user.groups.first.status ? 200 : 404)
        end

        it 'user logged in should not be able to create new contact other users group' do
            get "/groups/#{other_user.groups.first.id}/contacts/#{contacts.first.id}", headers: headers
            expect(response.status).to eq(404)
        end
    end

    context 'PUT /groups/:group_id/contacts/:id #update' do
        it 'user not logged in' do
            cnt1 = contacts.first
            cnt1.is_favorite = !cnt1.is_favorite
            put "/groups/#{user.groups.first.id}/contacts/#{cnt1.id}", params: {contact: cnt1.attributes}.to_json
            expect(json['message']).to eq('Missing token')
        end 

        it 'user logged in creates new contact(in his group)' do
            cnt1 = contacts.first
            cnt1.is_favorite = !cnt1.is_favorite
            put "/groups/#{user.groups.first.id}/contacts/#{cnt1.id}", params: {contact: cnt1.attributes}.to_json, headers: headers
            expect(response.status).to eq(user.groups.first.status ? 200 : 404)
        end

        it 'user logged in should not be able to create new contact other users group' do
            cnt1 = other_contacts.first
            cnt1.is_favorite = !cnt1.is_favorite
            put "/groups/#{user.groups.first.id}/contacts/#{cnt1.id}", params: {contact: cnt1.attributes}.to_json, headers: headers
            expect(response.status).to eq(404)
        end
    end

    context 'DELETE /groups/:group_id/contacts/:id #destroy' do

        it 'user not logged in' do
            delete "/groups/#{user.groups.first.id}/contacts/#{contacts.first.id}"
            expect(json['message']).to eq('Missing token')
        end 

        it 'user logged in deletes a contact(in his group)' do
            delete "/groups/#{user.groups.first.id}/contacts/#{contacts.first.id}", headers: headers
            expect(response.status).to eq(user.groups.first.status ? 200 : 404)
        end

        it 'user logged in should not be able to delete a contact from other users group' do
            get "/groups/#{other_user.groups.first.id}/contacts/#{other_contacts.first.id}", headers: headers, params: {contact: build(:contact, group_id: user.groups.first.id)}.to_json
            expect(response.status).to eq(404)
        end
    end
    
end