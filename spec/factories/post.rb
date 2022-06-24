FactoryBot.define do
  factory :post do
    association :user
    title {'My first post'}
    body {'Hi erevyone! This is my first post!'}
    picture { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/pixel.jpg')) }    
  end
end
