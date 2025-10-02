require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  let(:valid_attributes) do
    {
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '渋谷区',
      house_number: '神南1-19-11',
      building_name: '日本ビル',
      phone_number: '09012345678',
      token: 'tok_abcdefg12345',
      user_id: 1,
      item_id: 1
    }
  end

  describe '商品購入' do
    context '購入できる場合' do
      it 'すべての情報が正しく入力されていれば購入できる' do
        order_address = OrderAddress.new(valid_attributes)
        expect(order_address).to be_valid
      end
      
      it '建物名が空でも購入できる' do
        order_address = OrderAddress.new(valid_attributes.merge(building_name: ''))
        expect(order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it 'user_idが空だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(user_id: ''))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:user_id]).to include("can't be blank")
      end

      it 'item_idが空だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(item_id: ''))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:item_id]).to include("can't be blank")
      end

      it 'postal_codeが空だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(postal_code: ''))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:postal_code]).to include("can't be blank")
      end

      it 'postal_codeが不正な形式だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(postal_code: '1234567'))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:postal_code]).to include("is invalid. Include hyphen(-)")
      end

      it 'prefecture_idが1だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(prefecture_id: 1))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:prefecture_id]).to include("can't be blank")
      end

      it 'cityが空だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(city: ''))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:city]).to include("can't be blank")
      end

      it 'house_numberが空だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(house_number: ''))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:house_number]).to include("can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(phone_number: ''))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:phone_number]).to include("can't be blank")
      end

      it 'phone_numberが不正な形式だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(phone_number: '123'))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:phone_number]).to include("is invalid")
      end

      it 'tokenが空だと購入できない' do
        order_address = OrderAddress.new(valid_attributes.merge(token: ''))
        expect(order_address).not_to be_valid
        expect(order_address.errors[:token]).to include("can't be blank")
      end
    end
  end
end