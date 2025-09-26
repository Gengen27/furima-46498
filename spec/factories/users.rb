FactoryBot.define do
  factory :user do
    nickname { "テスト太郎" }
    email { Faker::Internet.unique.email }
    password { "test1234" }       # 半角英数字混合
    password_confirmation { "test1234" }
    last_name { "山田" }          # 全角
    first_name { "太郎" }         # 全角
    last_name_kana { "ヤマダ" }    # 全角カタカナ
    first_name_kana { "タロウ" }   # 全角カタカナ
    birthday { "1990-01-01" }     # 生年月日
  end
end
