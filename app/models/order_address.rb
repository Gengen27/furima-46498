# app/models/order_address.rb
class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id, :city,
                :house_number, :building_name, :phone_number, :token

  # バリデーションの定義
  validates :user_id, :item_id, :city, :house_number, :token, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: "is invalid" }
  
  # building_nameは任意項目（バリデーションなし）

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
