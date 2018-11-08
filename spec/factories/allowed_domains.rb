require 'faker'
FactoryBot.define do
    factory :allowed_domain do |f|
        f.domain { Faker::Internet.domain_name }
    end
end