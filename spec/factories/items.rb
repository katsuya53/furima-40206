FactoryBot.define do
  factory :item do
    name                   { Faker::Lorem.characters(number: rand(1..40)) } # 1から40文字のランダムな文字列を生成してnameに設定
    info                   { Faker::Lorem.sentence } # ランダムな文章を生成してinfoに設定
    category_id            { Faker::Number.between(from: 2, to: 11) } # 2から11までのランダムな数値を生成してidに設定
    sales_status_id        { Faker::Number.between(from: 2, to: 7) } # 2から7までのランダムな数値を生成してidに設定
    shipping_fee_status_id { Faker::Number.between(from: 2, to: 3) } # 2から3までのランダムな数値を生成してidに設定
    prefecture_id          { Faker::Number.between(from: 2, to: 48) } # 2から48までのランダムな数値を生成してidに設定
    scheduled_delivery_id  { Faker::Number.between(from: 2, to: 4) } # 2から4までのランダムな数値を生成してidに設定
    price                  { Faker::Number.between(from: 300, to: 9_999_999) } # 300から9999999のランダムな価格を設定
    user_id                { 1 } # 適切なUserのIDを設定（整数）
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
