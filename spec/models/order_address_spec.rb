require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user: @user, item: @item)
  end

  describe '商品購入' do
    context '購入できる場合' do
      it 'すべての情報が正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end
      
      it '建物名が空でも購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it 'user_idが空だと購入できない' do
        @order_address.user_id = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:user_id]).to include("can't be blank")
      end

      it 'item_idが空だと購入できない' do
        @order_address.item_id = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:item_id]).to include("can't be blank")
      end

      it 'postal_codeが空だと購入できない' do
        @order_address.postal_code = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:postal_code]).to include("can't be blank")
      end

      it 'postal_codeが不正な形式だと購入できない' do
        @order_address.postal_code = '1234567'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:postal_code]).to include("is invalid. Include hyphen(-)")
      end

      it 'prefecture_idが1だと購入できない' do
        @order_address.prefecture_id = 1
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:prefecture_id]).to include("can't be blank")
      end

      it 'cityが空だと購入できない' do
        @order_address.city = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:city]).to include("can't be blank")
      end

      it 'house_numberが空だと購入できない' do
        @order_address.house_number = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:house_number]).to include("can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        @order_address.phone_number = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include("can't be blank")
      end

      it '電話番号が9桁未満だと購入できない' do
        @order_address.phone_number = '12345678'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include("is invalid")
      end

      it '電話番号が12桁以上だと購入できない' do
        @order_address.phone_number = '123456789012'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include("is invalid")
      end

      it '電話番号が数字以外だと購入できない' do
        @order_address.phone_number = '090-1234-5678'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include("is invalid")
      end

      it 'tokenが空だと購入できない' do
        @order_address.token = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:token]).to include("can't be blank")
      end
    end
  end
end