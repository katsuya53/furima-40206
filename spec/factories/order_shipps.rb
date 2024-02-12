FactoryBot.define do
  factory :order_shipp do
    postal_code       { Faker::Number.decimal_part(digits: 3) + '-' + Faker::Number.decimal_part(digits: 4) } # 郵便番号が「3桁-4桁」の組み合わせ
    prefecture_id     { Faker::Number.between(from: 2, to: 48) } # 2から48までのランダムな数値を生成してidに設定
    city              { Faker::Lorem.sentence }
    addresses         { Faker::Lorem.sentence }
    building          { Faker::Lorem.sentence }
    phone_number      { Faker::PhoneNumber.unique.cell_phone.gsub(/\D/, '')[0, 11] } # 10桁以上11桁以内の半角数値
  end
end
