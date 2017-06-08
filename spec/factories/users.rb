FactoryGirl.define do
  pass = Faker::Internet.password(8)

  factory :user do
    name                    Faker::Name.name
    email                   Faker::Internet.email
    password                pass
    password_confirmation   pass
    created_at              DateTime.now
    updated_at              DateTime.now
  end
end
