FactoryBot.define do
  factory :memos, class: Micropost do
    trait :memo_1 do
      time { 240 }
      memo { "I just ate an orange!" }
      picture { nil }
      user_id { 1 }
      created_at { 10.minutes.ago }
    end

    trait :memo_2 do
      time { 180 }
      memo { "Check out the @tauday site by @mhartl: http://tauday.com" }
      picture { nil }
      user_id { 1 }
      created_at { 3.years.ago }
    end

    trait :memo_3 do
      time { 59 }
      memo { "Sad cats are sad: http://youtu.be/PKffm2uI4dk" }
      picture { nil }
      user_id { 1 }
      created_at { 2.hours.ago }
    end

    trait :memo_4 do
      time { 207 }
      memo { "Writing a short test" }
      picture { nil }
      user_id { 1 }
      created_at { Time.zone.now }
    end
    association :user, factory: :user
  end
end