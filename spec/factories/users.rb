require 'faker'
FactoryBot.define do
    factory :grp, class: 'Group' do 
        name { Faker::Name.name  }
        is_favorite { Faker::Boolean.boolean }
        status { Faker::Boolean.boolean }
        user
    end


    factory :userrole, class: 'UserRole' do
        role_id {Faker::Number.number(5)}
        user
    end

    factory :user do 
        name { Faker::Name.name }
        email { Faker::Internet.email }
        password { Faker::Internet.password }
        plain_identity { Faker::IDNumber.valid }

        factory :user_with_grps do
            transient do
              group_count {1}
            end
      
            after(:create) do |user, evaluator|
              FactoryBot.create_list(:group, evaluator.group_count, user: user)
              user.reload
            end
        end

        factory :user_with_adminrole do
            
            after(:create) do |user, evaluator|
              role = Role.find_or_create_by(name: 'admin')
              FactoryBot.create(:user_role,{role_id: role.id, user: user})
              user.reload
            end
        end
    end
end