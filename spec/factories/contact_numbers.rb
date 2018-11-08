require 'faker'
FactoryBot.define do
    factory :contact_number do |f|
        f.contact_type { Faker::Types.rb_string  }
        f.number { Faker::PhoneNumber.cell_phone }
        f.contact_id { nil }
    end
end