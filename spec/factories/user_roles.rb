require 'faker'
FactoryBot.define do
    factory :user_role do |f|
        f.role_id { Faker::Number.number(5) }
        f.user_id { Faker::Number.number(5) }
    end
end