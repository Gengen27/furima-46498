# app/models/order_address.rb
class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id, :city,
                :house_number, :building_name, :phone_number, :token

  # バリデーションの定義
  validates :user_id, :item_id, :city, :house_number, :token, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :phone_number, presence: true
  validate :phone_number_format
  
  # building_nameは任意項目（バリデーションなし）

  # カスタムバリデーション
  def phone_number_format
    return if phone_number.blank?
    
    # 数字以外が含まれている場合
    unless phone_number.match?(/\A\d+\z/)
      errors.add(:phone_number, "is invalid. Input only number")
      return
    end
    
    # 桁数チェック
    if phone_number.length < 10
      errors.add(:phone_number, "is too short")
    elsif phone_number.length > 11
      errors.add(:phone_number, "is invalid. Input only number")
    end
  end

  # 保存処理
  def save
    return false unless valid?
    
    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)
      Address.create!(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        house_number: house_number,
        building_name: building_name,
        phone_number: phone_number,
        order_id: order.id
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
