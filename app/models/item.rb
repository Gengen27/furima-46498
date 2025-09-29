class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  # ActiveHash 関連
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day

  # バリデーション
  validates :name, :description, :category_id, :condition_id,
            :shipping_fee_id, :prefecture_id, :shipping_day_id,
            :price, :image, presence: true

  validates :category_id, :condition_id, :shipping_fee_id,
            :prefecture_id, :shipping_day_id,
            numericality: { other_than: 0, message: "を選択してください" }

  validates :price, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9_999_999 }
end
