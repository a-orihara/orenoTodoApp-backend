FactoryBot.define do
  factory :todo do
    name { Faker::Name.initials(number: 21) }
  end
end
