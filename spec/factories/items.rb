FactoryBot.define do
  factory :item do
    name                  { 'テスト商品' }
    description           { 'テスト用の商品説明' }
    category_id           { 2 }
    condition_id          { 2 }
    shipping_fee_id       { 2 }
    prefecture_id         { 2 }
    shipping_day_id       { 2 }
    price                 { 500 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')), filename: 'test_image.png')
    end
  end
end