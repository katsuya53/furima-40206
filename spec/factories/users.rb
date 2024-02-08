FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) + '1a' } # 英数字の混合を末尾に追加
    password_confirmation { password }
    birth_date            { Date.new(2001, 1, 1) }
    first_name { '太郎' } # 適切な漢字、ひらがな、カタカナを設定
    last_name { '山田' }  # 適切な漢字、ひらがな、カタカナを設定
    first_name_kana { 'タロウ' } # 適切なカタカナを設定
    last_name_kana { 'ヤマダ' }  # 適切なカタカナを設定
  end
end
