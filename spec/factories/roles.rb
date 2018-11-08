require 'faker'
FactoryBot.define do
    factory :role do |f|
        f.name { Faker::Name.name }
    end
end