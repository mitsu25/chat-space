FactoryGirl.define do

  factory :message do
    body               Faker::ChuckNorris.fact
    image              File.open('spec/fixtures/files/sample.png')
    user
    group
  end

end
