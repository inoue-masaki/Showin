FactoryBot.define do
  factory :micropost do
    time { 1 }
    memo { "MyText" }
    picture { "MyString" }
    user { nil }
  end
end
