FactoryGirl.define do

  factory :message do
    body               Faker::ChuckNorris.fact
    image              File.open('spec/fixtures/files/sample.png')
    user_id
    group_id
  end

end
