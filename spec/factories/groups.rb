require 'faker'
FactoryBot.define do

    # factory :cnt, class: 'Contact' do
    #     name { Faker::Name.name  }
    #     is_favorite { Faker::Boolean.boolean }
    #     f.contact_numbers_attributes { [{contact_type: Faker::Types.rb_string, number: Faker::PhoneNumber.cell_phone }] }
    #     f.contact_emails_attributes { [{contact_type: Faker::Types.rb_string, email: Faker::Internet.email}] }
    #     f.contact_addresses_attributes { [{contact_type: Faker::Types.rb_string, address: Faker::Address.full_address}] }
    #     group
    #     user
    # end

    factory :group do 
        name { Faker::Name.name  }
        is_favorite { Faker::Boolean.boolean }
        status { Faker::Boolean.boolean }
        user_id { Faker::Number.number(5) }

        # factory :group_with_cnts do
        #     transient do
        #       contact_count {2}
        #     end
      
        #     after(:create) do |group, evaluator|
        #       FactoryBot.create_list(:cnt, evaluator.contact_count, group: group, user: group.user)
        #       group.reload
        #     end
        # end
    end
end