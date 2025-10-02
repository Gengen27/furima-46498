# app/models/order_address.rb
class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id, :city,
                :house_number, :building_name, :phone_number, :token

  # バリデーションの定義
  validate :validate_required_fields
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }, allow_blank: false
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid" }, allow_blank: false
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  private

  def validate_required_fields
    errors.add(:user_id, "can't be blank") if user_id.blank?
    errors.add(:item_id, "can't be blank") if item_id.blank?
    errors.add(:city, "can't be blank") if city.blank?
    errors.add(:house_number, "can't be blank") if house_number.blank?
    errors.add(:token, "can't be blank") if token.blank?
    errors.add(:postal_code, "can't be blank") if postal_code.blank?
    errors.add(:phone_number, "can't be blank") if phone_number.blank?
    errors.add(:prefecture_id, "can't be blank") if prefecture_id.blank?
  end
  
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
