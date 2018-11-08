require 'faker'
FactoryBot.define do
    factory :contact_address do |f|
        f.contact_type { Faker::Types.rb_string  }
        f.address { Faker::Address.full_address }
        f.contact_id { nil }
    end
end