FactoryBot.define do
  factory :reservation do
    guest
    start_date { Date.today }
    end_date { Faker::Date.forward(days: 5) }
    nights { Faker::Number.non_zero_digit }
    guests { Faker::Number.non_zero_digit }
    adults { Faker::Number.non_zero_digit }
    children { Faker::Number.non_zero_digit }
    infants { Faker::Number.non_zero_digit }
    currency { 'AUD' }
    payout_price { Faker::Number.decimal(l_digits: 4) }
    security_price { Faker::Number.decimal(l_digits: 4) }
    total_price { Faker::Number.decimal(l_digits: 4) }

    trait :pending do
      status { 'pending' }
    end

    trait :accepted do
      status { 'accepted' }
    end

    trait :rejected do
      status { 'rejected' }
    end
  end
end
