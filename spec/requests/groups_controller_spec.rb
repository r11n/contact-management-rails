require 'rails_helper'

RSpec.describe GroupsController do
    let(:allowed_domain){ create(:allowed_domain) }
    let(:user) { create(:user_with_grps, email: Faker::Internet.username+'@'+allowed_domain.domain) }   
    let(:other_user) { create(:user_with_grps, email: Faker::Internet.username+'@'+allowed_domain.domain) }   
    let(:headers) { valid_headers }
    
    context 'GET /groups #index' do
        it 'user not logged in' do
            get '/groups'
            expect(json['message']).to eq('Missing token')
        end
        it 'user logged in gets his groups' do
            get '/groups', headers: headers
            expect(json).to eq(user.groups.left_joins(:contacts).select('groups.id', 'groups.is_favorite', 'groups.name', 'groups.status', 'groups.user_id', 'count(contacts.*)').group('groups.id').order(:id).as_json)
        end

        it 'user logged in should not get other user groups' do
            get '/groups', headers: headers
            expect(json).not_to eq(other_user.groups.left_joins(:contacts).select('groups.id', 'groups.is_favorite', 'groups.name', 'groups.status', 'groups.user_id', 'count(contacts.*)').group('groups.id').order(:id).as_json)
        end
    end

    context 'POST /groups #create' do
        it 'user not logged in' do
            post '/groups',params: {group: build(:group).attributes}
            expect(json['message']).to eq('Missing token')
        end

        it 'user logged in creates a new valid group' do
            post '/groups',params: {group: build(:group).attributes.except('id')}.to_json, headers: headers
            expect(json['id']).not_to eq(nil)
            expect(response.status).to eq(201)
        end

        it 'user logged in creates a new invalid group' do
            post '/groups',params: {group: build(:group, name: nil).attributes.except('id')}.to_json, headers: headers
            expect(response.status).to eq(422)
        end
    end

    context 'GET /groups/:id #show' do
        it 'user not logged in' do
            get "/groups/#{user.groups.first.id}"
            expect(json['message']).to eq('Missing token')
        end

        it 'user logged in visits his group' do
            get "/groups/#{user.groups.first.id}", headers: headers
            expect(json['id']).to eq(user.groups.first.id)
            expect(response.status).to eq(200)
        end

        it 'user logged in visits other user group' do
            get "/groups/#{other_user.groups.first.id}", headers: headers
            expect(response.status).to eq(404)
        end
    end

    describe 'PUT /groups/:id #update' do
        it 'user not logged in' do
            put "/groups/#{user.groups.first.id}"
            expect(json['message']).to eq('Missing token')
        end

        it 'user logged in updates his group' do
            grp1 = user.groups.first
            grp1.status = !grp1.status
            put "/groups/#{grp1.id}",params: { group: grp1.attributes }.to_json ,headers: headers
            expect(response.status).to eq(200)
        end

        it 'user logged in updates other user group' do
            grp1 = other_user.groups.first
            grp1.user_id = user.id
            put "/groups/#{grp1.id}",params: { group: grp1.attributes }.to_json, headers: headers
            expect(response.status).to eq(404)
        end
    end

    context 'DELETE /groups/:id #destroy' do
        it 'user not logged in' do
            delete "/groups/#{user.groups.first.id}"
            expect(json['message']).to eq('Missing token')
        end

        it 'user logged in deletes his group' do
            delete "/groups/#{user.groups.first.id}", headers: headers
            expect(response.status).to eq(200)
        end

        it 'user logged in deletes other user group' do
            delete "/groups/#{other_user.groups.first.id}", headers: headers
            expect(response.status).to eq(404)
        end
    end
end