FactoryBot.define do
    factory :user do
      email { FFaker::Internet.email}
      username { FFaker::Name.name }
      password { 'qwqwqw' }
      password_confirmation { 'qwqwqw' }
    end
  end