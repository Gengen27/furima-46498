class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root
  before_action :set_gon

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?
      # PAY.JP課金処理
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      
      
      Payjp::Charge.create(
        amount: @item.price,
        card: params[:token],
        currency: 'jpy'
      )

      # Order と Address を保存
      @order_address.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city,
      :house_number, :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end

  def set_gon
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end
end
