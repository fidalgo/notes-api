FactoryGirl.define do

  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {Faker::Internet.password}
    # Use string roles because otherwise they will be passed and integers
    # leading to errors. Explanation: https://github.com/thoughtbot/factory_girl/issues/680
    role 'user'
    trait :admin do
      role 'admin'
    end
  end

  factory :guest, class: User do
    role :guest
  end

end
