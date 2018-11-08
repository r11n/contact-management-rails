require 'faker'
FactoryBot.define do
    factory :contact_email do |f|
        f.contact_type { Faker::Types.rb_string  }
        f.email { Faker::Internet.email }
        f.contact_id { nil }
    end
end