FactoryBot.define do
  factory :user do
    name { "Michael Example" }
    email { "michael@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  
  factory :other_user, class: User do
    name { "Sterling Archer" }
    email { "duchess@example.gov" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
  
  factory :no_activation_user, class: User do
    name { "No Activation" }
    email { "no@activation.co.jp" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { false }
  end
end