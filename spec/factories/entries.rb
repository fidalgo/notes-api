FactoryGirl.define do
  factory :entry do
    line "Faker::Company.catch_phrase"
    sequence :order
    note
  end

end
