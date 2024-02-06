FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    #first_name            { Faker::Name.first_name }
    #last_name             { Faker::Name.last_name }
    #first_name_kana       { Faker::Name.first_name }
    #last_name_kana        { Faker::Name.last_name }

    birth_date            { Date.new(2001, 1, 1) }
    first_name { '太郎' } # 適切な漢字、ひらがな、カタカナを設定
    last_name { '山田' }  # 適切な漢字、ひらがな、カタカナを設定
    first_name_kana { 'タロウ' } # 適切なカタカナを設定
    last_name_kana { 'ヤマダ' }  # 適切なカタカナを設定
    
  end
end