FactoryBot.define do
  factory :comment do
    association :post 
    association :user
    body {'Hi! Great post!'}
  end
end
  