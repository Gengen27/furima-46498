# app/models/order_address.rb
class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id, :city,
                :house_number, :building_name, :phone_number

  # 必須項目チェック
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :phone_number
  end

  # 郵便番号のフォーマット
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }

  # 電話番号のフォーマット（10〜11桁の半角数字）
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }

  # prefecture_id の numericality（未選択の1は弾く）
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  # 保存処理
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      house_number: house_number,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
