require 'faker'
FactoryBot.define do
    factory :contact do
        name { Faker::Name.name  }
        is_favorite { Faker::Boolean.boolean }
        group_id { Faker::Number.number(5) }
        user_id { Group.find(group_id).user_id }
        contact_numbers_attributes { [{contact_type: Faker::Types.rb_string, number: Faker::PhoneNumber.cell_phone }] }
        contact_emails_attributes { [{contact_type: Faker::Types.rb_string, email: Faker::Internet.email}] }
        contact_addresses_attributes { [{contact_type: Faker::Types.rb_string, address: Faker::Address.full_address}] }

        after(:create) do |contact, evaluator|
            contact.user.reload
        end
    end
end