class User < ApplicationRecord
  # Devise モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム必須
  validates :nickname, presence: true

  # 名前（全角）
  validates :last_name, :first_name, presence: true,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角で入力してください" }

  # 名前カナ（全角カタカナ）
  validates :last_name_kana, :first_name_kana, presence: true,
            format: { with: /\A[ァ-ンー]+\z/, message: "は全角カタカナで入力してください" }

  # 生年月日
  validates :birthday, presence: true

  # パスワード（半角英数字混合）
  validates :password, presence: true,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "は半角英数字混合で入力してください", allow_blank: true
}
end



      
