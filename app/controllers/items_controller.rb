class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_root, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def show
    redirect_to root_path, alert: '商品が存在しません' if @item.nil?
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path, notice: '出品しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    # 画像が空なら除外して更新する
    update_params = item_params
    update_params = item_params.except(:image) if item_params[:image].blank?

    if @item.update(update_params)
      redirect_to item_path(@item), notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id,
      :shipping_fee_id, :prefecture_id, :shipping_day_id,
      :price, :image
    )
  end

  def set_item
    @item = Item.find_by(id: params[:id])
  end

  def move_to_root
    redirect_to root_path unless current_user == @item.user
  end
end
