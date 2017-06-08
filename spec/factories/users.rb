FactoryGirl.define do
  pass = Faker::Internet.password(8)

  factory :user do
    name                    Faker::Name.name
    email                   Faker::Internet.email
    password                pass
    password_confirmation   pass
    created_at              DateTime.now
    updated_at              DateTime.now

    after(:create) do |user|
      user.groups << create_list(:group, 5)
    end
  end
end
