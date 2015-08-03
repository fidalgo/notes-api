FactoryGirl.define do
  factory :note do
    title { Faker::Company.name }
    user
  end

end
